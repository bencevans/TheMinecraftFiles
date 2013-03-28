
###*
 * Dependencies
###

async = require 'async'
db = require '../../db'
_ = require 'underscore'

###*
 * User Controller
###

module.exports.profile = (req, res, next) ->

  db.User.find({where: {username:req.params.username}}).success((user) ->
    unless user then return res.status(404).render('errors/404')
    res.locals.title = user.username
    user.getProjects().success((projects) ->
      async.map projects, (project, callback) ->
        project.getCreator().success((creator) ->
          callback(null, _.extend(project.values, {creator:creator.values}))
        ).error((error) ->
          callback error
        )
      , (error, projectsWithCreators) ->
        if error then return next error
        res.render 'user',
          profile: _.extend(user.values, {projects: projectsWithCreators})
    ).error((error) ->
      next error
    )
  ).error((error) ->
    next error
  )



