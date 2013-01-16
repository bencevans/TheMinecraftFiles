
###*
 * Dashboard Controller
###

module.exports = (app, tmf, db) ->

  return (req, res) ->

    tmf.getUser req.user._id, (err, dashboardUser) ->
      next(err) if err

      dashboardUser.getProjects (err) ->
        next(err) if err

        dashboardUser.getWatching (err) ->

          res.locals.title = 'Timeline'
          res.render 'timeline',
            usersFeedTimeline: []
            usersProjects: dashboardUser.projects
            usersWatching: dashboardUser.watching

