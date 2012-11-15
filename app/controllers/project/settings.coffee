app.get '/project/:projectSlug/settings', (req, res, next) ->
  return next()  unless req.project.isOwner
  res.render 'project/settings',
    layout: false
  , (err, html) ->
    return next(err)  if err
    res.render 'project',
      subPage:
        content: html



app.post '/project/:projectSlug/settings', (req, res, next) ->
  return next()  unless req.project.isOwner
  db.project.findById req.project._id, (err, project) ->
    return next(err)  if err
    project.name = req.body.name
    project.description = req.body.description
    project.githubRepoURI = req.body.githubrepouri
    project.save (err, project) ->
      return next(err)  if err
      res.redirect '/project/' + project.name + '/settings'



