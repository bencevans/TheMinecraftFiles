_ = require("underscore")
db = require("../../../db")

app.get '/new', (req, res, next) ->
  db.Category.findAll().success((categories) ->
    res.locals.title = 'New Project'
    res.render 'project/new',
      categories: categories
  ).error((error) ->
    next(err)
  )

app.post '/new', (req, res, next) ->
  if typeof req.body.name isnt 'undefined' and typeof req.body.category isnt 'undefined'
    res.locals.title = 'New Project'
    if req.body.name.match(/^[a-zA-Z|-|_]+$/m)
      db.Project.build(
        name: req.body.name
        category: req.body.category
        creator: req.user.id
      ).save().success((project) ->
        res.redirect '/project/' + project.name
        ### TODO
        tmf.createAction
          type: 'create'
          actor: req.user._id
          project: newproject._id
        , (err, action) ->
          next err if err
        ###
      ).error((error) ->
        next error
      )

      newproject.save (err, category) ->
        return next(err)  if err
        res.redirect '/project/' + category.name

    else
      db.Category.findAll().success((categories) ->
        req.flash 'Invalid Name'
        
        #Invalid Name Error
        res.render 'project/new', _.extend(
          categories: categories
        , req.body)
      ).error((error) ->
        next error
      )

  else

    # Not enouph data filled out.

    db.Category.findAll().success((categories) ->
      req.flash 'Please fill all required fields.'

      #Invalid Name Error
      res.render 'project/new', _.extend(
        categories: categories
      , req.body)
    ).error((error) ->
      next error
    )


