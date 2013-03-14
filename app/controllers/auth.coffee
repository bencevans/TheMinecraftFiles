
###*
 * Auth Controller
###

db = require "../../db"

module.exports.login = (req, res) ->
    res.locals.title = 'Login'
    if req.loggedIn
      res.redirect '/'
    else
      res.render 'login'

  # Aditional Info View and Save
  userInfo = {}

module.exports.settings = (req, res, next) ->
    res.render 'auth/user_info', req.user

module.exports.settingsAction = (req, res, next) ->
    res.render 'auth/user_info', req.user

# Logout handled by everyauth along with all login logic.
