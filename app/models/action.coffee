module.exports = new Schema(
  type: String
  actor: {type:ObjectId, ref:"user"}
  project: {type:ObjectId, ref:"project"}
  when: {type: Date, default: Date.now}
  data: Object
)
