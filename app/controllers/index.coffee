fs = require 'fs'
path = require 'path'
_ = require 'underscore'

module.exports = (app, sys) ->

  app.all '*', (req, res, next) ->
    if req.user
      res.locals.everyauth = user: req.user
      res.locals.everyauth.user.loggedIn = true
    next()

  require('./auth')(app, sys)
  require('./discover')(app, sys)
  require('./user')(app, sys)
  require('./project')(app, sys)

  _.each fs.readdirSync(path.resolve(__dirname, './project')), (file) ->
    require path.resolve(__dirname, './project/', file)

  # Check Authentication
  app.all '*', (req, res, next) ->
    if req.loggedIn
      next()
    else
      res.render 'errors/404',
        type: 404


  require('./dashboard')(app, sys)
  require('./settings')(app, sys)
  require('./comment')(app, sys)

  # 404
  app.all '*', (req, res) ->
    res.render 'errors/404',
      type: 404
