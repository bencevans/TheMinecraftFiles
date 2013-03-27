
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

module.exports.register = (req, res) ->
  res.render 'register'

module.exports.registerAction = (req, res, next) ->

  db.User.build(req.body).save().success((user) ->
    # TODO: flash message saying signed up successfully, or just login
    req.flash "Successfully created your user, please login."
    res.redirect "/"
  ).error((error) ->
    # TODO: better error, what constraint,  or is it a db problem
    next error
  )

module.exports.settings = (req, res, next) ->
  res.render 'auth/user_info', req.user

module.exports.settingsAction = (req, res, next) ->
  res.render 'auth/user_info', req.user

module.exports.logout = (req, res, next) ->
  req.logout()
  req.flash "Successfully Logged Out"
  res.redirect "/"
