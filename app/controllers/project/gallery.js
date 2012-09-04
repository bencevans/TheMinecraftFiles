var fs = require('fs');

app.get('/project/:projectSlug/gallery/:imageId.png', function (req, res, next) {
	db.galleryImage.findById(req.params.imageId, function(err, image) {
		if(err)
			return next(err);
		if(!image)
			return res.render('errors/404', {status:404});
		db.file.findById(image.file, function(err, file) {
			res.status(200).sendfile(file.path);
		});
	});
});

app.get('/project/:projectSlug/gallery/:imageId', function (req, res, next) {
	db.galleryImage.findById(req.params.imageId, function(err, galleryImage) {
		if(err)
			return next(err);
		if(!galleryImage)
			return res.render('errors/404', {status:404});
		galleryImage = galleryImage.toObject();
		galleryImage.src = "/project/" + req.project.name + "/gallery/" + galleryImage._id+'.png';
		galleryImage.href = "/project/" + req.project.name + "/gallery/" + galleryImage._id;
		res.render('project/gallery/image', {layout:false, galleryImage:galleryImage}, function (err, html) {
			if(err) return next(err);
			res.render('project', {subPage:{content:html}});
		});
	});
});

app.get('/project/:projectSlug/gallery/:imageId/delete', function (req, res, next) {

	if(!req.project.isOwner)
		return next();

	db.galleryImage.findById(req.params.imageId).populate('file').exec(function(err, galleryImage) {
		if(err)
			return next(err);
		if(!galleryImage)
			return res.render('errors/404', {status:404});

		galleryImage.remove(function(err) {
			if(err)
				return next(err);
			fs.unlink(galleryImage.file.path, function(err) {
				if(err)
					return next(err);
				galleryImage.file.remove(function(err) {
					if(err)
						return next(err);
					res.redirect('/project/' + req.params.projectSlug + '/gallery');
				})
			})
		});
	});
});

app.post('/project/:projectSlug/gallery', function (req, res, next) {

	if(!req.project.isOwner)
		return next();

	var upload = new db.file({path:req.files.galleryFileUpload.path});
	upload.save(function(err, upload) {
		if(err)
			return next(err);
		var galleryImage = new db.galleryImage({file:upload._id, project:req.project._id});
		galleryImage.save(function (err, galleryImage) {
			if(err)
				return next(err);
			res.redirect('/project/' + req.project.name + '/gallery/' + galleryImage._id);
		});
	});
});