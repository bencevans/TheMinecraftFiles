module.exports = function (app, db) {
	app.get('/user/:username', function (req, res) {

		db.user.findOne({username: req.params.username}, function (err, user) {
			if(user !== null) {
				// User Exists
				res.render('user', {profile:user});
			} else {
				// No User Exists
				res.render('errors/404', {
					type: 404
				});

			}
		})
	})
}