hbs.registerHelper('user_preferred_name', function(userProfile) {
	if(typeof userProfile.realName !== "undefined")
		return userProfile.realName;
	return userProfile.username;
});

hbs.registerHelper('gravatar_url', function(gravatarHash, size) {
	if(typeof gravatarHash !== "string")
		return false;
	if(gravatarHash.match(/@/))
		gravatarHash = helpers.md5(gravatarHash);
	return "http://www.gravatar.com/avatar/" + gravatarHash + "?s=" + size || 140;
});