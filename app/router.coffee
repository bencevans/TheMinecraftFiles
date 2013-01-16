
fs = require 'fs'
path = require 'path'
_ = require 'underscore'
routes = {}

###*
 * Error Routes
###

app.get '/500', (req, res, next) ->
  next 'Test Error'

app.get '/404', (req, res, next) ->
  next 404

###*
 * Home Route
###

app.get '/', (req, res, next) ->
  if req.loggedIn
    next()
    return true
  res.render 'index'

###*
 * Feed Current Users Info to View Engine
###

app.all '*', (req, res, next) ->
  if req.user
    res.locals.everyauth = user: req.user
    res.locals.everyauth.user.loggedIn = true
  next()

###*
 * External Routes
###

routes.auth = require('./controllers/auth')(app, tmf, db)

app.get '/login', routes.auth.login
app.get '/auth/user_info', routes.auth.userInfo.show
app.post '/auth/user_info', routes.auth.userInfo.update

routes.discover = require('./controllers/discover')(app, tmf, db)

app.get '/discover', routes.discover.index
app.get '/discover/:categorySlug', routes.discover.category
app.get '/discover/:categorySlug/popular', routes.discover.category.popular
app.get '/discover/:categorySlug/recent', routes.discover.category.recent
app.get '/discover/:categorySlug/trending', routes.discover.category.trending

routes.user = require('./controllers/user')(app, tmf, db)

app.get '/user/:username', routes.user.profile

routes.project = require('./controllers/project')(app, tmf, db)

app.all '/project/:projectSlug/:subPage?*', routes.project.all
app.get '/project/:projectSlug/gallery', routes.project.gallery

_.each fs.readdirSync(path.resolve(__dirname, './controllers/project')), (file) ->
  require path.resolve(__dirname, './controllers/project/', file)


###*
 * Authenticated Routes
###

app.all '*', (req, res, next) ->
  if req.loggedIn
    next()
  else
    res.render 'errors/404',
      type: 404


routes.dashboard = require('./controllers/dashboard')(app, tmf, db)

app.get '/', routes.dashboard

routes.settings = require('./controllers/settings')(app, tmf, db)

app.get '/settings', routes.settings.index
app.get '/settings/:subPage', routes.settings.subPage
app.post '/settings/profile', routes.settings.profile
app.post '/settings/account', routes.settings.account

routes.comment = require('./controllers/comment')(app, tmf, db)

app.get '/comments', routes.comment.find
app.post '/comment', routes.comment.create


# 404
app.all '*', (req, res) ->
  res.render 'errors/404',
    type: 404

