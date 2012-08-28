
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

	db.project.findOne({name:req.params.projectSlug}, function (err, project) {

		if(err) return next(err);

		if(!project) return res.render('errors/404', {status:404});

		res.locals.title = project.name;

		res.render('project', {project:project});

	});

});

