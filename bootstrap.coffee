###*
 *
 * bootsrap.coffee
 *
 * Sets up connections/config that's generic to any sub-app.
 *
###

###*
 * Dependencies
###

debug = require('debug')('bootstrap')
_ = require 'underscore'
fs = require 'fs'
mongoose = require 'mongoose'

###*
 * Setup TMF Lib & Connect to DBs
 * @param  {object} config
 * @return {array}        [tmf, db, redisClient]
###

module.exports = (config) ->

  # Open a connection with MongoDB (Database)
  mongoConn = mongoose.connect config.mongo.uri or 'mongodb://localhost/TheMinecraftFiles', (err) ->
    if err
      console.error 'Error connecting to monogo:', err
    else
      debug 'Mongoose connected to MongoDB'

  # Setup Redis (Key-Value Store used for storing authenticated sessions)
  #
  # REDISTOGO_URL is the ENVIROMENT variable Heroku (Cloud Web Host) use
  # to provide Redis connection Info.
  if (process.env.REDISTOGO_URL)
    debug('Creating a REDISTOGO Redis Client')
    rtg   = require('url').parse(process.env.REDISTOGO_URL)
    global.redisClient = require('redis').createClient(rtg.port, rtg.hostname)
    global.redisClient.auth(rtg.auth.split(':')[1])
  else
    debug('Creating a local Redis Client')
    global.redisClient = require('redis').createClient()


  # Make required functions/classes/objects available globally (So
  # they can be accessed outside of the bootstrap script).
  Schema = mongoose.Schema
  ObjectId = Schema.ObjectId
  global.db = {}

  debug('Loading Mongoose Schemas')

  # Read each Database Model and pull it into a Schema + Model for Mongoose
  _.each fs.readdirSync('./app/models'), (fileName, index) ->

    # Retreive Schema Name from the filename (user.js => user)
    schemaName = fileName.match(/([a-zA-Z]+)\..+/)[1]
    db[schemaName] = mongoose.model(schemaName, require('./app/models/' + fileName)(Schema, ObjectId))
    debug('Loaded %s Schema', schemaName)

  # Setup TMF (TheMinecraftFiles) Library
  global.tmf = require(__dirname + '/lib/tmf')
  tmf.db = global.db
  tmf.setupCache redisClient, (err) ->
    if err then throw err
    debug 'Setup TMF Lib Cache'

  return [tmf, db, redisClient]
