
###*
 * Dependencies
###

_ = require("underscore")
async = require 'async'
db = require("../../../db")

module.exports.new = (req, res, next) ->
  db.Category.findAll().success((categories) ->
    res.locals.title = 'New Project'
    res.render 'project/new',
      categories: categories
  ).error((error) ->
    next(err)
  )

module.exports.newAction = (req, res, next) ->
  if typeof req.body.name isnt 'undefined' and typeof req.body.category isnt 'undefined'
    res.locals.title = 'New Project'
    if req.body.name.match(/^[a-zA-Z|-|_]+$/m)

      # find category
      db.Category.find({where:{id:req.body.category}}).success((category) ->
        unless category then return next new Error('No category found by that id')

        # all params seem ok, create the project
        db.Project.build(
          name: req.body.name
          category: req.body.category
        ).save().success((project) ->

          project.setCategory(category).success((project)->

            project.setCreator(req.user).success((creator)->
              console.log('new creator, ', creator)

              # TODO: Create User's 'Project Created' Event/Timeline Action
              res.redirect '/project/' + project.name
            ).error((error) ->
              next error
            )

          ).error((error) ->
            next error
          )

        ).error((error) ->
          next error
        )
      ).error((error) ->
        next error
      )

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


