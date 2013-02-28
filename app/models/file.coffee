module.exports = (Schema, ObjectId) ->
  return new Schema(
    type:
      type: String

    added:
      type: Date
      default: Date.now

    path:
      type: String
      required: true
  )
