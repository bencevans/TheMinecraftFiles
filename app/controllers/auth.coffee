
module.exports = (app, sys) ->

  # Login Page.
  app.get '/login', (req, res) ->
    res.locals.title = 'Login'
    if req.loggedIn
      res.redirect '/'
    else
      res.render 'login'

  # Aditional Info View and Save
  app.get '/auth/user_info', (req, res, next) ->
    res.render 'auth/user_info', req.user

  app.post '/auth/user_info', (req, res, next) ->
    res.render 'auth/user_info', req.user

  #Logout, handled by everyauth along with all login logic.
