
###*
 * Dependencies
###

db = require "../../db"
async = require "async"
util = require "util"
_ = require "underscore"

###*
 * Dashboard Controller
###

###*
 * Gather aditional information for rendering actions
 * @param  {Array of|Action Object}   action
 * @param  {Function} callback      callback signature (err, actions)
###
actionBuilder = (action, callback) ->
  if util.isArray(action)
    async.map action, actionBuilder, callback
  else
    action.getActor({attributes: ['username', 'id', 'realName', 'email']}).success (actor) ->
      action.getProject().success (project) ->
        project = project or {name:'deleted'}
        callback null, _.extend action.values, _.extend {project:project.values}, {actor:actor.values}
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
          res.locals.usersWatching = watchingProjects
          done()
        ).error(done)
      , (done) ->
        db.sequelize.query('SELECT Actions.id, Actions.type,  Actions.data,  Actions.createdAt, Actions.updatedAt, Actions.UserId,  Actions.ProjectId FROM Actions INNER JOIN Watches ON Actions.ProjectId=Watches.ProjectId WHERE Watches.UserId=' + dashUser.id).success((actions) ->
          actions = _.map actions, (action) ->
            return db.Action.build(action)
          actionBuilder(actions, (error, actionsWithExtras) ->
            res.locals.usersFeedTimeline = actionsWithExtras
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

