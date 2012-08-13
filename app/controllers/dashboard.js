
app.get('/', function (req, res) {

	db.project.find({creator: req.user._id}, function (err, usersProjects) {
		res.render('timeline', {
			usersFeedTimeline : [],
			usersProjects: usersProjects
		});
	})

});
