module.exports = (Schema, ObjectId) ->
  return new Schema(
    type:
      type: String

    added:
      default: Date.now

    path:
      type: String
      required: true
  )
