
###*
 * Dependencies
###

debug = require('debug')('ui')
express = require 'express'
fs = require 'fs'
http = require 'http'
flashify = require 'flashify'
_ = require 'underscore'
bcrypt = require 'bcrypt'

###*
 * Globals (Ideally be removed and pass objects as params)
###

global.app = express()
global.hbs = require 'hbs'
global.config = require '../config'

###*
 * Bootstrap
 * Sets up TMF lib, DBs etc
###

debug('Starting Bootstrap')
[tmf, db, redisClient] = require('../bootstrap')(config)

###*
 * RedisStore
 * Stores cross-server sessions
###

if process.env.REDISTOGO_URL
  redisStore = require('connect-heroku-redis')(express)
else
  redisStore = require('connect-redis')(express)

###*
 * User Authentication
###

passport = require('passport')
db = require('../db')

passport.serializeUser((user, callback) ->
  callback null, user.id
)

passport.deserializeUser((userId, callback) ->
  db.User.find({where:{id:userId}}).success((user) ->
    callback null, user
  ).error((error) ->
    callback error
  )
)

passport.use require("./auth/local")
passport.use require("./auth/github")
passport.use require("./auth/twitter")



###*
 * Configure View Engine
###

_.each fs.readdirSync('./app/view_helpers'), (view_helper) ->
  require './view_helpers/' + view_helper


###*
 * Configure App
###

app.configure 'development', ->
  app.use express.logger('dev')

app.configure ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'html'
  app.engine 'html', hbs.__express
  app.use express['static'](__dirname + '/public')
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.session
    secret: 'dsfdsf'
    store: new redisStore()

  app.use passport.initialize()
  app.use passport.session()
  app.use flashify
  app.use app.router
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
  app.use (err, req, res, next) ->
    console.error err
    res.render 'errors/404'  if err is 404
    res.render 'errors/500'


app.configure 'development', ->
  app.use express['static'](__dirname + '/public')
  
  # app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
  app.use (err, req, res, next) ->
    console.error err
    res.send 500, 'Sorry We\'ve had a problem'


app.configure 'production', ->
  oneYear = 31557600000
  app.use express['static'](__dirname + '/public',
    maxAge: oneYear
  )

###*
 * Force HTTP Location & PJAX
###

app.all '*', (req, res, next) ->

  # Force Domain if Config Options are set.
  if config.forceLocation
    if config.forceLocation.domain
      if req.domain != config.forceLocation.domain
        # Redirect with Defaults if Required
        res.redirect (if config.forceLocation.protocol then config.forceLocation.protocol else 'http://') +
        config.forceLocation.domain +
        (if config.forceLocation.port then ':' + config.forceLocation.port else '') + req.url

  # PJAX
  res.locals.layout = 'layout-pjax.html'  if req.headers['x-pjax']
  next()


###*
 * Load Router
###

app.post "/login", passport.authenticate("local",
  failureRedirect: "/login"
  failureFlash: true
), (req, res) ->
  res.redirect "/"


app.get "/auth/github", passport.authenticate("github")
app.get "/auth/github/callback", passport.authenticate("github",
  failureRedirect: "/login"
), (req, res) ->

  # Successful authentication, redirect home.
  res.redirect "/"

app.get "/auth/twitter", passport.authenticate("twitter")
app.get "/auth/twitter/callback", passport.authenticate("twitter",
  failureRedirect: "/login"
), (req, res) ->

  # Successful authentication, redirect home.
  res.redirect "/"

require './router'



if module.parent
  debug('Exporting app')
  module.exports = app
else
  server = http.createServer(app)
  debug('Hooking up port')
  server.listen app.get('port')
  debug 'TheMinecraftFiles is listening on port ' + app.get 'port'

if app.get('env') is 'development'
  growl = require 'growl'
  growl 'TheMinecraftFiles is listening on port ' + app.get 'port'
