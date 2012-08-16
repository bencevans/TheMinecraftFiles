
app.get('/user/:username', function (req, res) {

	db.user.findOne({username: req.params.username}, function (err, user) {

		if(err) return next(err);

		res.locals.title = user.username;

		if(user !== null) {
			user.gravatarhash = helpers.md5('ben@bensbit.co.uk');
			// User Exists
			res.render('user', {profile:user});

		} else {
			// No User Exists
			res.render('errors/404', {
				type: 404
			});

		}
	});
});
