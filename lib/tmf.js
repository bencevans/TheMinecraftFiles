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

exports.dashboard.timeline = function() {

	if(unauthenticated == false)
		return Error('Authentication Required')
	else
		// return timeline.

}

exports.users.profile = function (username) {
	return {
		id: 1
		username: "bencevans",
		realName: "Ben Evans",
		website: "https://bensbit.co.uk",
		projects: [{name:"techno", href:"http://bensbit.co.uk/techno", members:["bencevans", "mrmattyboy"]}], //...
		followers: 20,
		following: 5,
		watching: 45,
	}
}

exports.users.projects = function (username) {
	return [{name:"techno", href:"...", members:["bencevans", "mrmattyboy"]}]; //...
}

exports.users.update = function (username, updates) {
	return true;
}