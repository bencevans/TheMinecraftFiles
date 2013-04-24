
express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router

app.configure "development", ->
  app.use express.errorHandler()

app.get "/project/:project", routes.project
app.get "/user/:user", routes.user
app.get "/user/:user/projects", routes.user.projects
app.get "*", (req, res, next) ->
  res.status(404).send message: "Not Found"

module.exports = app