exports.index = function (req, res) {
	res.render('discover')
}
exports.category = function (req, res) {
	res.render('discover_category', {})
}
exports.categoryPopular = function (req, res) {
	res.send('Not Here Yet', 404)
}
exports.categoryRecent = function (req, res) {
	res.send('Not Here Yet', 404)
}
exports.categoryTrending = function (req, res) {
	res.send('Not Here Yet', 404)
}