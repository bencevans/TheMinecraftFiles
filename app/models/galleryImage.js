module.exports = new Schema({
	name: { type: String, match: /^.{0,12}$/ },
	file: { type: Schema.ObjectId, required: true },
	project: { type: Schema.ObjectId, required: true },
	description: { type: String, match: /^.{0,24}$/}
});