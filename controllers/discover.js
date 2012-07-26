module.exports = function (app, db) {

	app.get('/discover', function (req, res) {
		res.render('discover')
	})

	app.get('/discover/:categorySlug', function (req, res) {
		res.render('discover_category', {})
	})

	app.get('/discover/:categorySlug/popular', function (req, res) {
		res.send('Not Here Yet', 404)
	})

	app.get('/discover/:categorySlug/recent', function (req, res) {

		res.send('Not Here Yet', 404)
	})

	app.get('/discover/:categorySlug/trending', function (req, res) {
		res.send('Not Here Yet', 404)
	})

}