
app.get('/project/:projectSlug/timeline', function (req, res, next) {

	res.render('project/timeline', {layout:false}, function (err, html) {
		if(err) return next(err);
		res.render('project', {subPage:{content:html}});
	});

});