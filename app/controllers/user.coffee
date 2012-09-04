app.get "/user/:username", (req, res, next) ->
  tmf.getUser req.params.username, (err, user) ->
    return next(err)  if err
    if user isnt null
      
      # User Exists
      res.locals.title = user.username
      res.render "user",
        profile: user

    else
      
      # No User Exists
      res.render "errors/404",
        type: 404



