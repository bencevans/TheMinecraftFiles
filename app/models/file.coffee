module.exports = (Schema, ObjectId) ->
  return new Schema(
    type:
      type: String
      default: Date.now

    path:
      type: String
      required: true
  )
