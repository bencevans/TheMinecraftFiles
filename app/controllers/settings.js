

app.get('/settings', function (req, res) {
	res.redirect('/settings/profile')
})

app.get('/settings/:subPage', function (req, res) {

	var subPages = {
		profile: {name:'Profile', slug:'profile'}
	}

	if(typeof subPages[req.params.subPage] == "undefined")
		res.render('errors/404', {
			type: 404
		});
	else
		res.partial('settings/profile', {}, function(err, view) {


			res.render('settings', {
				subPages: helpers._.toArray(subPages),
				subPage: {view:view, name:subPages[req.params.subPage].name, slug:subPages[req.params.subPage].slug}
			})

		})
	
})

