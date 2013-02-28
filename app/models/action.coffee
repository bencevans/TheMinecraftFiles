module.exports = (Schema, ObjectId) ->
  return new Schema(

    type:
      type: String
      required: true

    actor:
      type: ObjectId
      ref: 'user'
      required: true

    project:
      type: ObjectId
      ref: 'project'
      required: true

    when:
      type: Date
      default: Date.now

    data: Object

  )
