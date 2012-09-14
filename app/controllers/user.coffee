async = require 'async'

app.get "/user/:username", (req, res, next) ->
  tmf.getUser req.params.username, (err, user) ->
    return next(err)  if err
    if user isnt null
      
      # User Exists
      res.locals.title = user.username

      user.getProjects ->
        async.map user.projects, (project, callback) ->
          project.getCreator (err) ->
            callback err, project
        , (err, results) ->
          console.log results
          res.render "user",
           profile: user

    else
      
      # No User Exists
      res.render "errors/404",
        type: 404



