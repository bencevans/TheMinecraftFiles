###*
 * Route Loader
###

fs = require("fs")
routes = fs.readdirSync(__dirname)
routeFunctions = {}
i = routes.length - 1

while i >= 0
  routeFunctions[routes[i].match(/^(.+)\.[coffee|js]+$/)[1]] = require("./" + routes[i])  if routes[i] isnt "index.js"
  i--

module.exports = routeFunctions