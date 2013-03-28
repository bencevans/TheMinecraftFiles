
###*
 * Dependencies
###

fs = require 'fs'
path = require 'path'
_ = require 'underscore'
routes = {}

###*
 * Error Routes
###

app.get '/500', (req, res, next) ->
  next new Error 'Test Error'

app.get '/404', (req, res, next) ->
  next 404

###*
 * Home Route
###

app.get '/', (req, res, next) ->
  if req.isAuthenticated()
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
 * Require Route Controllers
###


routes.auth = require('./controllers/auth')
routes.discover = require('./controllers/discover')
routes.user = require('./controllers/user')
routes.project = require('./controllers/project')
routes.dashboard = require('./controllers/dashboard')
routes.settings = require('./controllers/settings')
routes.comment = require('./controllers/comment')
routes.new = require('./controllers/project/new')

###*
 * External Routes
###

# Auth
app.get '/login', routes.auth.login
app.get '/logout', routes.auth.logout

app.get '/register', routes.auth.register
app.post '/register', routes.auth.registerAction
app.get '/auth/user_info', ensureAuthenticated, routes.auth.settings
app.post '/auth/user_info', ensureAuthenticated, routes.auth.settingsAction

# Discover
app.get '/discover', routes.discover.index
app.get '/discover/:categorySlug', routes.discover.category
app.get '/discover/:categorySlug/popular', routes.discover.category.popular
app.get '/discover/:categorySlug/recent', routes.discover.category.recent
app.get '/discover/:categorySlug/trending', routes.discover.category.trending

# User Profiles
app.get '/user/:username', routes.user.profile

# Projects
app.all '/project/:project/:subPage?*', routes.project.all


routes.project = routes.project or {}
_.each fs.readdirSync(path.resolve(__dirname, './controllers/project')), (file) ->
  routes.project[file.match(/^(.+)\.coffee$/)[1]] = require path.resolve(__dirname, './controllers/project/', file)

app.get '/project/:projectSlug/downloads', routes.project.downloads.index
app.get '/project/:project/gallery', routes.project.gallery.index
app.get '/project/:projectSlug/gallery/:imageId.png', routes.project.gallery.imageFile
app.get '/project/:projectSlug/gallery/:imageId', routes.project.gallery.image
app.post '/project/:projectSlug/gallery', routes.project.gallery.new
app.get '/project/:projectSlug/gallery/:imageId/default', ensureAuthenticated, routes.project.gallery.setDefault
app.get '/project/:projectSlug/gallery/:imageId/delete', ensureAuthenticated, routes.project.gallery.delete
app.get '/project/:projectSlug/gallery', routes.project.gallery.index
app.get '/project/:projectSlug/issues', routes.project.issues.index
app.get '/project/:projectSlug/issues/:issueid', routes.project.issues.issue
app.get '/project/:projectSlug/settings', routes.project.settings.index
app.post '/project/:projectSlug/settings', routes.project.settings.indexAction
app.get '/project/:projectSlug/timeline', routes.project.timeline.index
app.get '/project/:projectSlug/watch', routes.project.watch.watch
app.get '/project/:projectSlug/unwatch', routes.project.watch.unwatch

###
 * Authenticated Routes
###

ensureAuthenticated = (req, res, next) ->
  return next()  if req.isAuthenticated()
  res.redirect "/login"

app.get '/', ensureAuthenticated, routes.dashboard.index

app.get '/settings', ensureAuthenticated, routes.settings.index
app.get '/settings/:subPage', ensureAuthenticated, routes.settings.subPage
app.post '/settings/profile', ensureAuthenticated, routes.settings.profile
app.post '/settings/account', ensureAuthenticated, routes.settings.account



app.get '/comments', ensureAuthenticated, routes.comment.find
app.post '/comment', ensureAuthenticated, routes.comment.create


app.get '/new', ensureAuthenticated, routes.new.new
app.post '/new', ensureAuthenticated, routes.new.newAction

# 404
app.all '*', (req, res) ->
  res.render 'errors/404',
    type: 404

