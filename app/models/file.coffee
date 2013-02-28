module.exports = (Schema, ObjectId) ->
  return new Schema(
    type:
      type: String

    path:
      type: String
      required: true
  )
