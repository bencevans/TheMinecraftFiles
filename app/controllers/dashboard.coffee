
###*
 * Dashboard Controller
###

db = require "../../db"

module.exports.index = (req, res, next) ->
  console.log req.user
  db.User.find(
    id: req
  ).success((dashboardUser) ->
    console.log "dash", dashboardUser
    dashboardUser.getProjects().success((projects) ->
      #dashboardUser.getWatching().success((projects) ->
      res.locals.title = 'Timeline'
      res.render 'timeline',
        usersFeedTimeline: []
        usersProjects: dashboardUser.projects
        usersWatching: dashboardUser.watching
      #).error (error) ->
      #  next error
    ).error (error) ->
      next error
  ).error (error) ->
    next error
