module.exports = new Schema(
  name: String
  slug:
    type: String
    lowercase: true
    trim: true
    unique: true
)
