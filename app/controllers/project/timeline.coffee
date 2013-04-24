async = require 'async'
util = require 'util'
_ = require 'underscore'

actionBuilder = (action, callback) ->
  if util.isArray(action)
    async.map action, actionBuilder, callback
  else
    action.getActor({attributes: ['username', 'id', 'realName', 'email']}).success (actor) ->
      action.getProject().success (project) ->
        callback null, _.extend action.values, _.extend {project:project.values}, {actor:actor.values}
      .error callback
    .error callback

module.exports.index = (req, res, next) ->

  req.project.getActions().success((actions) ->
    actionBuilder actions, (error, actions) ->
      console.log actions
      res.render 'project/timeline',
          actions: actions
          layout: false
        , (err, html) ->
          return next(err)  if err
          res.render 'project',
            subPage:
              content: html
  ).error((err) ->
    next err
  )
