var categorySchema = new Schema({
	name: String,
	slug: { type: String, lowercase: true, trim: true }
});

mongoose.model('category', categorySchema);