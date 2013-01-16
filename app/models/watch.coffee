module.exports = (Schema, ObjectId) ->
  return new Schema(
    user:
      type: Schema.ObjectId
      required: true

    watching:
      type: Schema.ObjectId
      required: true

    when:
      type:Date
      default:Date.now
  )
