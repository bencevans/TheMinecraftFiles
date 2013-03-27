module.exports.index = (req, res, next) ->
  return next()  unless req.project.isOwner
  res.render 'project/settings',
    layout: false
  , (err, html) ->
    return next(err)  if err
    res.render 'project',
      subPage:
        content: html



module.exports.indexAction = (req, res, next) ->
  return next()  unless req.project.isOwner

  req.project.updateAttributes
    name: req.body.name
    description: req.body.description
    githubRepoURI: req.body.githubrepouri
  .success (project) ->
    res.redirect '/project/' + project.name + '/settings'
  .error next

