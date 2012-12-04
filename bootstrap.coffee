_ = require 'underscore'
fs = require 'fs'
mongoose = require 'mongoose'
mongoConn = mongoose.connect(config.mongo.uri or 'mongodb://localhost/TheMinecraftFiles', (err) ->
  if err
    console.log config.mongo
    console.error err
    )

if (process.env.REDISTOGO_URL)
  rtg   = require('url').parse(process.env.REDISTOGO_URL)
  global.redisClient = require('redis').createClient(rtg.port, rtg.hostname)
  global.redisClient.auth(rtg.auth.split(':')[1])
else
  global.redisClient = require('redis').createClient()



#if(!err)
#   console.log('MongoDB Connected.');
# else
#   console.warn('Unable to Connect to MongoDB');
global.Schema = mongoose.Schema
global.ObjectId = Schema.ObjectId
global.db = {}

_.each fs.readdirSync('./app/models'), (fileName, index) ->

  # Retreive Schema Name (user.js => user)
  schemaName = fileName.match(/([a-zA-Z]+)\..+/)[1]
  global.db[schemaName] = mongoose.model(schemaName, require('./app/models/' + fileName))

# Setup TMF (TheMinecraftFiles) Library
global.tmf = require(__dirname + '/lib/tmf')
tmf.db = global.db
