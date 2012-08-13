
app.get('/new', function (req, res) {
	res.render('project/new');
})

app.post('/new', function (req, res) {
	if(typeof req.body.name !== 'undefined' && typeof req.body.category !== 'undefined' ) {

		if(req.body.name.match('/\^[a-zA-Z|-|_]\/')) {
			res.send('OK')
		} else {
			//Invalid Name Error
			res.render('project/new', req.body);
		}

	} else {
		// Not enouph data filled out.
		res.render('project/new', req.body);

	}
	
})

app.get('/project/:projectSlug', function (req, res) {
	res.render('project');
})

