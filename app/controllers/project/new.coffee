_ = require("underscore")

app.get "/new", (req, res, next) ->
  db.category.find {}, (err, categories) ->
    return next(err)  if err
    res.locals.title = "New Project"
    res.render "project/new",
      categories: categories



app.post "/new", (req, res, next) ->
  if typeof req.body.name isnt "undefined" and typeof req.body.category isnt "undefined"
    res.locals.title = "New Project"
    if req.body.name.match(/^[a-zA-Z|-|_]+$/m)
      newproject = new db.project(
        name: req.body.name
        category: req.body.category
        creator: req.user._id
      )
      newproject.save (err, category) ->
        return next(err)  if err
        res.redirect "/project/" + category.name

        tmf.createAction
          type: "create"
          actor: req.user._id
          project: newproject._id
        , (err, action) ->
          next err if err

    else
      db.category.find {}, (err, categories) ->
        return next(err)  if err
        req.flash "Invalid Name"
        
        #Invalid Name Error
        res.render "project/new", _.extend(
          categories: categories
        , req.body)

  else
    
    # Not enouph data filled out.
    req.flash "Please fill all required fields."
    db.category.find {}, (err, categories) ->
      return next(err)  if err
      
      #Invalid Name Error
      res.render "project/new", _.extend(
        categories: categories
      , req.body)


