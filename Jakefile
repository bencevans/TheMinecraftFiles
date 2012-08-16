namespace('setup', function() {

	desc('Setup Default Categories');
	task('categories', ['npm'], function (params) {

		_ = require('underscore');
		fs = require('fs');
		mongoose = require('mongoose');
		mongoose.connect('mongodb://localhost/TheMinecraftFiles', function (err) {
			if(!err)
				console.log('MongoDB Connected.');
			else
				console.warn('Unable to Connect to MongoDB');
		});

		Schema = mongoose.Schema
		, ObjectId = Schema.ObjectId;

		db = {}

		_.each(fs.readdirSync('./app/models'), function (fileName, index) {
			// Retreive Schema Name (user.js => user)
			var schemaName = fileName.match(/([a-zA-Z]+)\.js/)[1];
			db[schemaName] = mongoose.model(schemaName, require('./app/models/' + fileName));
		});


		var defaultCategories = ['Skins', 'Mods', 'Textures'];

		_.each(['Skins', 'Mods', 'Textures'], function (category){

			var newCategory = new db.category({
				name: category,
				slug: category.toLowerCase()
			});
			newCategory.save(function (err, item) {
				if(err)
					console.error(err);
				else
					console.log(category + ' category created.');
			});

		})

		complete();


	});

task('npm', function (params) {

	console.log("Installing NPM Modules listed in package.json");

	jake.exec(['npm install'], function () {

		complete();

	}, {printStdout: true, async:false})

});

});

