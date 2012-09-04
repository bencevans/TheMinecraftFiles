fs = require("fs")
path = require("path")
_ = require("underscore")
app.all "*", (req, res, next) ->
  if req.user
    res.locals.everyauth = user: req.user
    res.locals.everyauth.user.loggedIn = true
  next()

require "./auth"
require "./discover"
require "./user"
require "./project"
_.each fs.readdirSync(path.resolve(__dirname, "./project")), (file) ->
  require path.resolve(__dirname, "./project/", file)


# Check Authentication
app.all "*", (req, res, next) ->
  if req.loggedIn
    next()
  else
    res.render "errors/404",
      type: 404


require "./dashboard"
require "./settings"

# 404
app.all "*", (req, res) ->
  res.render "errors/404",
    type: 404


