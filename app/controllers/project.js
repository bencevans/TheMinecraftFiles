
app.get('/new', function (req, res) {

	db.category.find({}, function (err, categories) {
		console.log(categories);
		res.render('project/new', {categories:categories});
	});

});

app.post('/new', function (req, res) {
	if(typeof req.body.name !== 'undefined' && typeof req.body.category !== 'undefined' ) {
		console.log(req.body.name);
		if(req.body.name.match(/^[a-zA-Z|-|_]+$/m)) {

			var newproject = new db.project({
				name: req.body.name,
				category: req.body.category
			});
			newproject.save(function (err, category) {
				if(err)
					return false;
				res.redirect('/project/' + category.name);
			});

		} else {
			db.category.find({}, function (err, categories) {
				console.log('Invalid Name');
				//Invalid Name Error
				res.render('project/new', _.extend({categories:categories}, req.body));
			});

		}

	} else {
		console.log('Not Enoutph');
		// Not enouph data filled out.
		db.category.find({}, function (err, categories) {
				//Invalid Name Error
				res.render('project/new', _.extend({categories:categories}, req.body));
			});

	}
	
});

app.get('/project/:projectSlug', function (req, res) {

	db.project.findOne({name:req.params.projectSlug}, function (err, project) {

		if(err) return res.send(500);

		if(!project) return res.send(404);

		res.render('project', {project:project});

	});

});

