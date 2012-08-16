

app.get('/settings', function (req, res) {
	res.redirect('/settings/profile');
});

app.get('/settings/:subPage', function (req, res) {

	var subPages = {
		profile: {name:'Profile', slug:'profile'}
	};

	if(typeof subPages[req.params.subPage] == "undefined")
		res.render('errors/404', {
			type: 404
		});
	else
		db.user.findById(req.user._id, function(err, userSettings) {
			res.render('settings/' + req.params.subPage, {layout:false, userSettings:userSettings}, function(err, view) {

				if(err) return next(err);

				res.render('settings', {
					subPages: helpers._.toArray(subPages),
					subPage: {view:view, name:subPages[req.params.subPage].name, slug:subPages[req.params.subPage].slug}
				});

			});
		});
	
});

app.post('/settings/profile', function (req, res) {
	db.user.update(req.user, req.body, function (err, user) {
		if(err) return next(err);
		res.redirect('/settings/profile');
	});
})