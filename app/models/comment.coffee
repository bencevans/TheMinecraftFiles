module.exports = (Schema) ->
  new Schema(
    creator:
      type: Schema.ObjectId
      required: true
      ref: 'user'

    text:
      type: String
      required: true

    created:
      type: Date
      required: true
      default: Date.now

    identifier:
      id:
        type: Schema.ObjectId
        required: true
      type:
        type: String
        required: true

  )
