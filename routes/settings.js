exports.index = function (req, res) {
	res.redirect('/settings/profile')
}
exports.page = function (req, res) {
	res.render('settings', {})
}