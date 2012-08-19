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
			returnUser.gravatarhash = helpers.md5('default-user@theminecraftfiles.com');

			callback(null, returnUser);
		});
	});
}


}

