express = require("express")
stylus = require("stylus")
fs = require("fs")
redisStore = require("connect-redis")(express)
crypto = require("crypto")
http = require("http")
global.app = express()
server = http.createServer(app)
flashify = require("flashify")
_ = require("underscore")
global.hbs = require("hbs")

global.config = mongo: {}

# Bootstrap (DB Etc.)
require "./bootstrap"

# TMF Library
tmf = require("./lib/tmf")
tmf.db = db

# Authentication Requirements
global.everyauth = require("everyauth")
_.each fs.readdirSync("./app/auth"), (authModule) ->
  require "./app/auth/" + authModule

everyauth.everymodule.logoutRedirectPath "/"
everyauth.everymodule.findUserById (userId, callback) ->
  db.user.findById userId, (err, data) ->
    callback err, data



# App Config
app.configure "development", ->
  app.use express.logger("dev")
  everyauth.debug = true

app.configure ->
  app.set "views", __dirname + "/app/views"
  app.set "view engine", "html"
  app.engine "html", hbs.__express
  app.use express.cookieParser()
  app.use express.session(
    secret: "dsfdsf"
    store: new redisStore()
  )
  app.use express.bodyParser()
  app.use everyauth.middleware(app)
  app.use express.methodOverride()
  app.use express["static"](__dirname + "/public")
  app.use flashify
  app.use app.router
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
  app.use (err, req, res, next) ->
    console.error err
    res.render "errors/404"  if err is 404
    res.render "errors/500"


app.configure "development", ->
  app.use express["static"](__dirname + "/public")
  
  # app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
  app.use (err, req, res, next) ->
    console.error err
    res.send 500, "Sorry We've had a problem"


app.configure "production", ->
  oneYear = 31557600000
  app.use express["static"](__dirname + "/public",
    maxAge: oneYear
  )


# app.use(express.errorHandler());

# PJAX
app.all "*", (req, res, next) ->
  res.locals.layout = "layout-pjax.html"  if req.headers["x-pjax"]
  next()

app.get "/", (req, res, next) ->
  if req.loggedIn
    next()
    return true
  res.render "index"


# Setup Helpers required in controllers
global.helpers = {}
helpers._ = _
helpers.md5 = (string) ->
  crypto.createHash("md5").update(string).digest "hex"


# Register hbs/handlebars helpers & partials
_.each fs.readdirSync("./app/view_helpers"), (view_helper) ->
  require "./app/view_helpers/" + view_helper

app.get "/500", (req, res, next) ->
  next "Test Error"

app.get "/404", (req, res, next) ->
  next 404

app.get "/worker", (req, res, next) ->
  cluster = require("cluster")
  res.send 200, cluster.worker.process.pid + " " + cluster.worker.id

require "./app/controllers"
server.listen process.env.PORT or 3000
