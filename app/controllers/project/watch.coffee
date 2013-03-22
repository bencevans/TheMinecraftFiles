module.exports.watch = (req, res, next) ->
  if not req.user
    return res.redirect '/login?r=/project/' + req.project.name
  req.project.watch req.user._id, (err, watching) ->
    next err if err
   
    tmf.createAction
      type:'watch'
      actor:req.user._id
      project:req.project._id
    , (err, action) ->
      next err if err

      res.redirect '/project/' + req.project.name

module.exports.unwatch = (req, res, next) ->
  if not req.user
    return res.redirect '/login?r=/project/' + req.project.name
  req.project.unwatch req.user._id, (err, watching) ->
    next err if err
    res.redirect '/project/' + req.project.name