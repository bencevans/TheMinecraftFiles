
app.get('/project/:projectSlug/settings', function (req, res, next) {

	if(!req.project.isOwner)
		return next();

	res.render('project/settings', {layout:false}, function (err, html) {
		if(err) return next(err);
		res.render('project', {subPage:{content:html}});
	});

});

app.post('/project/:projectSlug/settings', function (req, res, next) {

	if(!req.project.isOwner)
		return next();

	db.project.findById(req.project._id, function (err, project) {

		if(err)
			return next(err);

		project.name = req.body.name;
		project.description = req.body.description;

		project.save(function (err, project) {
			if(err)
				return next(err);
			res.redirect('/project/' + project.name + '/settings');
		});
	});
});