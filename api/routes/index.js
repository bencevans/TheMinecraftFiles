/*
// Route Loader
*/

var fs = require('fs');

var routes = fs.readdirSync(__dirname);
var routeFunctions = {};

for (var i = routes.length - 1; i >= 0; i--) {
  if(routes[i] !== 'index.js')
    routeFunctions[routes[i].match(/^(.+)\.[coffee|js]+$/)[1]] = require('./' + routes[i]);
}

module.exports = routeFunctions;
