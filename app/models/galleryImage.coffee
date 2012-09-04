module.exports = new Schema(
  name:
    type: String
    match: /^.{0,12}$/

  file:
    type: Schema.ObjectId
    ref: "file"

  project:
    type: Schema.ObjectId
    required: true
    ref: "project"

  description:
    type: String
    match: /^.{0,24}$/
)
