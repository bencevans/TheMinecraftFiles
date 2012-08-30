module.exports = new Schema({
	type: { type: String, 'default': Date.now },
	path: { type: String, required: true }
});