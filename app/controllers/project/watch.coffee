
db = require "../../../db"

module.exports.watch = (req, res, next) ->

  if not req.isAuthenticated()
    return res.redirect '/login?r=/project/' + req.project.name

  req.project.addWatcher(req.user).success (watch) ->

    db.Action.build({type:'WatchProject'}).save().success((action) ->
      action.setActor(req.user).success((action) ->
        action.setProject(req.project).success((action) ->
          res.redirect '/project/' + req.project.name
        ).error((err) ->
          next err
        )
      ).error (err) ->
        next err
    ).error (err) ->
      next err

  .error next


module.exports.unwatch = (req, res, next) ->
  if not req.user
    return res.redirect '/login?r=/project/' + req.project.name
  req.project.removeWatcher(req.user).success(->
    res.redirect '/project/' + req.project.name
  ).error next