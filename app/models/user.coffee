module.exports = new Schema(
  username:
    type: String
    required: true
    lowercase: true
    trim: true
    index:
      unique: true
      sparse: true

  password: String
  email: String
  joined:
    type: Date
    default: Date.now

  realName: String
  minecraftUsername: String
  website: String
  twitterUsername: String
  gitHubUsername: String
  gitHubID: String
)

#mongoose.model('user', userSchema)
