app.get "/project/:projectSlug/timeline", (req, res, next) ->
  res.render "project/timeline",
    layout: false
  , (err, html) ->
    return next(err)  if err
    res.render "project",
      subPage:
        content: html



