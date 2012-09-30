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

  email:
    type: String
    match: /^.+@.+\..+$/

  joined:
    type: Date
    default: Date.now

  realName: String

  minecraftUsername:
    type: String
    match: /^[A-Za-z0-9_]+$/

  website:
    type: String
    match: /^https?\:\/\/.+\..+$/

  twitterUsername:
    type: String
    match: /^[A-Za-z0-9_]+$/

  gitHubUsername:
    type: String
    match: /^[A-Za-z0-9_]+$/

  gitHubID: Number
)
