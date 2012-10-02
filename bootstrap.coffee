_ = require("underscore")
fs = require("fs")
mongoose = require("mongoose")
mongoConn = mongoose.connect(config.mongo.uri or "mongodb://localhost/TheMinecraftFiles", (err) ->
  if err console.error err
)

#if(!err)
#		console.log('MongoDB Connected.');
#	else
#		console.warn('Unable to Connect to MongoDB');
global.Schema = mongoose.Schema
global.ObjectId = Schema.ObjectId
global.db = {}

_.each fs.readdirSync("./app/models"), (fileName, index) ->
  
  # Retreive Schema Name (user.js => user)
  schemaName = fileName.match(/([a-zA-Z]+)\..+/)[1]
  global.db[schemaName] = mongoose.model(schemaName, require("./app/models/" + fileName))

global.tmf = require(__dirname + "/lib/tmf")
tmf.db = global.db
