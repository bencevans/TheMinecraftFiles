module.exports = function (app, db) {

	app.get('/project/:projectSlug', function (req, res) {
		res.render('project');
	})
	
}