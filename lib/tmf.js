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

	async.series([
		function(callback){
			self.db.user.findOne({username: userIdentifier}, callback);
		},
		function(callback){
			self.db.project.find({creator: '5009dc1dfecef90000000009'}, callback);
		}
		],
		function(err, results){
			if(err)
				return callback(err);

			var user = results[0];
			user.projects = results[1];
			user.gravatarhash = helpers.md5('ben@bensbit.co.uk');
			callback(null, user)
		});


}

