module.exports = new Schema({
	category: { type: Schema.ObjectId, ref:'category' },
	created: { type: Date, 'default': Date.now },
	creator: { type: Schema.ObjectId, ref:'user' },
	image: { type: Schema.ObjectId, ref:'galleryImage' },
	name: { type: String, required: true, trim: true, index: { unique: true, sparse: true } },
	description: {type: String, match: /.{0,24}/}
});