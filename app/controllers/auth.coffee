
###*
 * Auth Controller
###

module.exports = (app, tmf, db) ->

  # Login Page.
  login = (req, res) ->
    res.locals.title = 'Login'
    if req.loggedIn
      res.redirect '/'
    else
      res.render 'login'

  # Aditional Info View and Save
  userInfo = {}

  userInfo.show = (req, res, next) ->
    res.render 'auth/user_info', req.user

  userInfo.update = (req, res, next) ->
    res.render 'auth/user_info', req.user

  #Logout, handled by everyauth along with all login logic.
  
  return {login, userInfo}