
###*
 * Dashboard Controller
###

db = require "../../db"
async = require "async"
util = require "util"
_ = require "underscore"

actionBuilder = (action, callback) ->
  if util.isArray(action)
    async.map action, actionBuilder, callback
  else
    action.getActor({attributes: ['username', 'id', 'realName', 'email']}).success (actor) ->
      action.getProject().success (project) ->
        callback null, _.extend action.values, _.extend {project:project}, {actor:actor.values}
      .error callback
    .error callback

module.exports.index = (req, res, next) ->

  db.User.find({where:{id:req.user.id}}).success((dashUser) ->
    async.parallel([
      (done) ->
        dashUser.getProjects().success((usersProjects) ->
          res.locals.usersProjects = usersProjects
          done()
        ).error(done)
      , (done) ->
        dashUser.getWatching().success((watchingProjects) ->
          res.locals.watchingProjects = watchingProjects
          done()
        ).error(done)
      , (done) ->
        dashUser.getActions({order:'createdAt DESC', limit:30}).success((actions) ->
          actionBuilder(actions, (error, actionsWithExtras) ->
            res.locals.usersFeedTimeline = actionsWithExtras
            console.log res.locals.usersFeedTimeline
            done()
          )
        ).error(done)
    ], (err) ->
      if err then return next err
      res.render 'timeline'
    )

  ).error((error) ->
    next error
  )

