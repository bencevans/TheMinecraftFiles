async = require 'async'

app.get '/project/:projectSlug/timeline', (req, res, next) ->
  req.project.getTimeline (err, project) ->
    async.map project.timeline, (action, callback) ->
      action.getActor (err, project) ->
        return callback err if err
        action.getProject callback

    , (err, timeline) ->
      return next err if err
      res.render 'project/timeline',
        layout: false
      , (err, html) ->
        return next(err)  if err
        res.render 'project',
          subPage:
            content: html



