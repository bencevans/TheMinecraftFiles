
app.get('/new', function (req, res, next) {
	db.category.find({}, function (err, categories) {

		if(err) return next(err);

		res.locals.title = 'New Project';

		res.render('project/new', {categories:categories});
	});

});

app.post('/new', function (req, res, next) {
	if(typeof req.body.name !== 'undefined' && typeof req.body.category !== 'undefined' ) {

		res.locals.title = 'New Project';

		if(req.body.name.match(/^[a-zA-Z|-|_]+$/m)) {

			var newproject = new db.project({
				name: req.body.name,
				category: req.body.category,
				creator: req.user._id
			});
			newproject.save(function (err, category) {

				if(err) return next(err);

				res.redirect('/project/' + category.name);
			});

		} else {
			db.category.find({}, function (err, categories) {

				if(err) return next(err);

				req.flash('Invalid Name');

				//Invalid Name Error
				res.render('project/new', _.extend({categories:categories}, req.body));
			});

		}

	} else {

		// Not enouph data filled out.

		req.flash('Please fill all required fields.');

		db.category.find({}, function (err, categories) {

			if(err) return next(err);

			//Invalid Name Error
			res.render('project/new', _.extend({categories:categories}, req.body));
		});

	}
	
});

app.get('/project/:projectSlug', function (req, res, next) {
	res.redirect('/project/' + req.params.projectSlug + '/timeline');
});

app.all('/project/:projectSlug/:subPage', function (req, res, next) {

	tmf.getProject(req.params.projectSlug, function (err, project) {

		if(err) return next(err);

		if(!project) return res.render('errors/404', {status:404});

		res.locals.title = project.name;
		req.project = res.locals.project = project;
		
		
		res.locals.subPages = [{name:'Timeline', slug:'timeline', url:'/project/' + project.name + '/timeline'},
		{name:'Gallery', slug:'gallery', url:'/project/' + project.name + '/gallery'},
		{name:'Downloads', slug:'downloads', url:'/project/' + project.name + '/downloads'},
		{name:'Settings', slug:'settings', url:'/project/' + project.name + '/settings'},
		{name:'Issues', slug:'issues', url:'/project/' + project.name + '/issues'}]

		res.locals.subPage = _.find(res.locals.subPages, function(subPage) {
			if(req.params.subPage == subPage.slug) {
				subPage.current = true;
				return true;
			}
		})

		next();

	});

});


app.get('/project/:projectSlug/timeline', function (req, res, next) {

	res.render('project/timeline', {layout:false}, function (err, html) {
		if(err) return next(err);
		res.render('project', {subPage:{content:html, name:'Timeline', slug:'timeline'}})
	});

});

app.get('/project/:projectSlug/downloads', function (req, res, next) {

	res.render('project/downloads', {layout:false}, function (err, html) {
		if(err) return next(err);
		res.render('project', {subPage:{content:html, name:'Timeline', slug:'downloads'}})
	});

});

app.get('/project/:projectSlug/gallery', function (req, res, next) {
	
	res.render('project/gallery', {layout:false}, function (err, html) {
		if(err) return next(err);
		res.render('project', {subPage:{content:html, name:'Timeline', slug:'gallery'}})
	});

});

app.get('/project/:projectSlug/settings', function (req, res, next) {

	res.render('project/settings', {layout:false}, function (err, html) {
		if(err) return next(err);
		res.render('project', {subPage:{content:html, name:'Timeline', slug:'settings'}})
	});

});