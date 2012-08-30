app.get('/project/:projectSlug', function (req, res, next) {
	res.redirect('/project/' + req.params.projectSlug + '/timeline');
});

app.all('/project/:projectSlug/:subPage*', function (req, res, next) {

	tmf.getProject(req.params.projectSlug, function (err, project) {

		if(err) return next(err);

		if(!project) return res.render('errors/404', {status:404});

		res.locals.title = project.name;
		req.project = res.locals.project = project;
		
		
		res.locals.subPages = [{name:'Timeline', slug:'timeline', url:'/project/' + project.name + '/timeline'},
		{name:'Gallery', slug:'gallery', url:'/project/' + project.name + '/gallery'},
		{name:'Downloads', slug:'downloads', url:'/project/' + project.name + '/downloads'},
		{name:'Issues', slug:'issues', url:'/project/' + project.name + '/issues'}];

		res.locals.subPage = _.find(res.locals.subPages, function(subPage) {
			if(req.params.subPage == subPage.slug) {
				subPage.current = true;
				return true;
			}
		});

		if(req.user && project.creator._id.toString() == req.user._id.toString()) {
			project.isOwner = true;
			res.locals.subPages.push({name:'Settings', slug:'settings', url:'/project/' + project.name + '/settings'});
		}

		next();

	});

});

app.get('/project/:projectSlug/gallery', function (req, res, next) {

	db.galleryImage.find({project:req.project._id}, function(err, galleryImages) {

		async.map(galleryImages, function(galleryImage, callback) {
			db.file.findById(galleryImage.file, function(err, galeryImageFile) {
				galleryImage = galleryImage.toObject();
				galleryImage.src = "/project/" + req.project.name + "/gallery/" + galleryImage._id+'.png';
				galleryImage.href = "/project/" + req.project.name + "/gallery/" + galleryImage._id;
				callback(err, galleryImage);
			});
		}, function(err, results) {
			if(err)
				return next(err);

			res.render('project/gallery', {layout:false, galleryImages:results}, function (err, html) {
				if(err) return next(err);
				res.render('project', {subPage:{content:html}});
			});
		});
	});
});


