module.exports = (Schema) ->
  new Schema(
    type:
      type: String
      default: Date.now

    path:
      type: String
      required: true
  )
