module.exports = (Schema, ObjectId) ->
  return new Schema(
    name:
      type: String
      required: true

    slug:
      type: String
      lowercase: true
      trim: true
      unique: true
  )
