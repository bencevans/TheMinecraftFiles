
app.get('/', function (req, res) {

	db.project.find({creator: req.user._id}, function (err, usersProjects) {

		if(err) return next(err);

		res.render('timeline', {
			usersFeedTimeline : [],
			usersProjects: usersProjects
		});
	});

});
