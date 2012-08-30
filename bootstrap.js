var _ = require('underscore');
var fs = require('fs');
mongoose = require('mongoose');
mongoConn = mongoose.connect(config.mongo.uri || 'mongodb://localhost/TheMinecraftFiles', function (err) {
	/*if(!err)
		console.log('MongoDB Connected.');
	else
		console.warn('Unable to Connect to MongoDB');*/
});

Schema = mongoose.Schema;
ObjectId = Schema.ObjectId;

db = {};

_.each(fs.readdirSync('./app/models'), function (fileName, index) {
	// Retreive Schema Name (user.js => user)
	var schemaName = fileName.match(/([a-zA-Z]+)\.js/)[1];
	db[schemaName] = mongoose.model(schemaName, require('./app/models/' + fileName));
});

tmflib = require('./lib/tmf.js');
tmf= tmflib.createInterface(db);