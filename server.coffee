#
# server.coffee
#
# This file is used to load all the sub-apps (Web Interface + API) and work 
# as a switch for incoming connections, tunneling them to the appropriate sub-app
#

# Include Express. Express is a Framework to ease the development on Web Servers.
express = require 'express'

# Include the Web Interface App.
webInterface = require './app.coffee'

# Include the API Interface App
apiInterface = require './api/app.js'

# Create an instance of Express Web Framework
app = express()

# The following 2 lines create routes so that if the visitors
# host (URL) matches the string, it will forward the request
# to the appropriate sub-app.
app.use express.vhost('api.*', apiInterface)
app.use express.vhost('*', webInterface)

# Start the webserver, opening a port connection to either
# a given port from the systems ENVIROMENT settings, else port 3000.
app.listen process.env.PORT || 3000
