

app.get('/discover', function (req, res) {

	db.category.find({}, function (err, categories) {

		if(err) return next(err);

		res.render('discover', {categories:categories});
	});

	
});

app.get('/discover/:categorySlug', function (req, res) {

	db.category.findOne({slug:req.params.categorySlug}, function (err, category) {

		if(err) return next(err);

		if (!category)
			res.send(404);
		else
			res.render('discover_category', {category:category});
	});

});

app.get('/discover/:categorySlug/popular', function (req, res) {
	res.send('Not Here Yet', 404);
});

app.get('/discover/:categorySlug/recent', function (req, res) {

	res.send('Not Here Yet', 404);
});

app.get('/discover/:categorySlug/trending', function (req, res) {
	res.send('Not Here Yet', 404);
});
