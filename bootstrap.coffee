#
# bootsrap.coffee
#
# Sets up connections/config that's generic to any sub-app.
#

# Require underscore, a library of helpers
_ = require 'underscore'

# Require the FileSystem ('fs') module
fs = require 'fs'

# Require Mongoose ODM, Database Client & Data Modeling
mongoose = require 'mongoose'

# Open a connection with MongoDB (Database)
mongoConn = mongoose.connect config.mongo.uri or 'mongodb://localhost/TheMinecraftFiles', (err) ->
  if err
    console.log config.mongo
    console.error err

# Setup Redis (Key-Value Store used for storing authenticated sessions)
#
# REDISTOGO_URL is the ENVIROMENT variable Heroku (Cloud Web Host) use
# to provide Redis connection Info.
if (process.env.REDISTOGO_URL)
  rtg   = require('url').parse(process.env.REDISTOGO_URL)
  global.redisClient = require('redis').createClient(rtg.port, rtg.hostname)
  global.redisClient.auth(rtg.auth.split(':')[1])
else
  global.redisClient = require('redis').createClient()


# Make required functions/classes/objects available globally (So 
# they can be accessed outside of the bootstrap script).
global.Schema = mongoose.Schema
global.ObjectId = Schema.ObjectId
global.db = {}

# Read each Database Model and pull it into a Schema + Model for Mongoose
_.each fs.readdirSync('./app/models'), (fileName, index) ->

  # Retreive Schema Name from the filename (user.js => user)
  schemaName = fileName.match(/([a-zA-Z]+)\..+/)[1]
  global.db[schemaName] = mongoose.model(schemaName, require('./app/models/' + fileName))

# Setup TMF (TheMinecraftFiles) Library
global.tmf = require(__dirname + '/lib/tmf')
tmf.db = global.db
