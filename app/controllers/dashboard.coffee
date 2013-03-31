
###*
 * Dashboard Controller
###

db = require "../../db"

module.exports.index = (req, res, next) ->
  db.User.find(
    where:
      id: req.user.id
  ).success((dashboardUser) ->
    dashboardUser.getProjects().success((usersProjects) ->
      dashboardUser.getWatching().success((watchingProjects) ->
        res.locals.title = 'Timeline'
        res.render 'timeline',
          usersFeedTimeline: []
          usersProjects: usersProjects
          usersWatching: watchingProjects
      ).error (error) ->
        next error
    ).error (error) ->
      next error
  ).error (error) ->
    next error
