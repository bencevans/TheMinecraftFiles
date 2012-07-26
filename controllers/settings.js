module.exports = function (app, db) {

	app.get('/settings', function (req, res) {
		res.redirect('/settings/profile')
	})

	app.get('/settings/:subPage', function (req, res) {
		res.render('settings', {})
	})

}