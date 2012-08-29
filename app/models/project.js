module.exports = new Schema({
	category: Schema.ObjectId,
	created: { type: Date, 'default': Date.now },
	creator: { type: Schema.ObjectId, required: true },
	image: Schema.ObjectId,
	name: { type: String, required: true, trim: true, index: { unique: true, sparse: true } },
	description: {type: String, match: /.{0,24}/}
});