module.exports = new Schema({
	category: Schema.ObjectId,
	created: { type: Date, default: Date.now },
	creator: Schema.ObjectId,
	image: Schema.ObjectId,
	name: String,
	slug: { type: String, required: true, lowercase: true, trim: true, index: { unique: true, sparse: true } }
});