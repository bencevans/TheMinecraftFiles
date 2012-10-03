app.get "/project/:projectSlug/downloads", (req, res, next) ->

  req.project.getDownloads (err, project) ->

    res.render "project/downloads",
      layout: false
    , (err, html) ->
      return next(err)  if err
      res.render "project",
        subPage:
          content: html



