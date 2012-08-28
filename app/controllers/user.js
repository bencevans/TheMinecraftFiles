
app.get('/user/:username', function (req, res, next) {

	tmf.getUser(req.params.username, function(err, user) {
		if(err) return next(err);

		if(user !== null) {

			// User Exists
			res.locals.title = user.username;
			res.render('user', {profile:user});

		} else {
			// No User Exists
			res.render('errors/404', {
				type: 404
			});

		}
	});
});
