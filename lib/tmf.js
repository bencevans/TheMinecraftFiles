/*

dashboard.timeline

users.profile :username
users.projects :username
users.watching
users.following
users.update :username? {name:"New Name"}

projects.overview :projectName
projects.update :projectName? {website:"http://projectssite.com"}
projects.members :projectName

issues.overiew :projectName {paginationOptions etc.}
issues.new :projectName {}

*/
async  = require('async');

// db = pbject containing all Mongo Models.

exports.createInterface = function(db) {
	return new Interface(db);
}


var Interface = function(db) {
	this.db = db;
	self = this;
	return this;

}

Interface.prototype.getUser = function (userIdentifier, callback) {

	self.db.user.findOne({username: userIdentifier}, function (err, user) {
		if(err)
			return callback(err, null);
		if(!user)
			return callback(null, user);

		self.db.project.find({creator: user._id}, function (err, projects) {
			if(err)
				return callback(err);

			var returnUser = user;
			returnUser.projects = projects;
			returnUser.gravatarhash = helpers.md5(returnUser.email||'default-user@theminecraftfiles.com');

			callback(null, returnUser);
		});
	});
}

Interface.prototype.getCategory = function (categoryIndetifier, callback) {

	self.db.category.findOne({slug: categoryIndetifier}, function (err, category) {
		if(err)
			return callback(err, null);
		if(!category)
			return callback(null, category);

		async.parallel([
			function(callback){
				// Gather Popular
				callback(null, null);
			},
			function(callback){
				// Gather Recent
				self.db.project.find({category: category._id}, callback);
			},
			function(callback){
				// Gather Trending
				callback(null, null);
			}
			],
			function(err, results){
				if(err)
					return callback(err);

				var returnCategory = category;
				returnCategory.popular = results[0];
				returnCategory.recent = results[1];
				returnCategory.trending = results[2];
				callback(null, returnCategory)
			});


	});


}

Interface.prototype.getProject = function (nameIndetifier, callback) {

	self.db.project.findOne({name: nameIndetifier}, function (err, project) {
		if(err)
			return callback(err, null);
		if(!category)
			return callback(null, project);

		this.getUser(project.creator, function (err, creator) {
			if(err)
				return callback(err, null);
			if(!category)
				return callback(null, project);

			var returnProject = category;
			returnProject.creator = creator;
			callback(null, returnProject)


		})

	});

}

