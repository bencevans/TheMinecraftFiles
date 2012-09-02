hbs.registerHelper('time_ago', function(date, size) {

	// Inspired by https://github.com/elving/swag/blob/00b3213de4811c0f27cb46c89b8ddae6b2e15702/src/swag.dates.coffee#L94

	date = new Date(date);
	seconds = Math.floor((new Date() - date) / 1000);

	interval = Math.floor(seconds / 31536000);
	if (interval > 1)
		return interval + " years ago";

	interval = Math.floor(seconds / 2592000);
	if (interval > 1)
		return interval + " months ago";

	interval = Math.floor(seconds / 86400);
	if (interval > 1)
		return interval + " days ago";

	interval = Math.floor(seconds / 3600);
	if (interval > 1)
		return interval + " hours ago";

	interval = Math.floor(seconds / 60);
	if (interval > 1)
		return interval + " minutes ago";

	if (Math.floor(seconds) === 0)
		return 'Just now';
	else
		return Math.floor(seconds) + ' seconds ago';

});