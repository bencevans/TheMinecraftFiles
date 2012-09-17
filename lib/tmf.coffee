# Requires
crypto = require("crypto")
_ = require 'underscore'
async = require 'async'

# Helpers
md5 = (string) ->
  crypto.createHash("md5").update(string).digest "hex"


# db = Object containing all Mongo Models.
db
exports.db = db

# getUser - get info about a particular user
exports.getUser = getUser = (userIdentifier, callback) ->
  self = this
  self.db.user.findOne (if (typeof userIdentifier is "object") then _id: userIdentifier else username: userIdentifier), (err, userMongoObject) ->
    return callback(err, null)  if err
    return callback(null, userMongoObject)  unless userMongoObject
    new user userMongoObject.toObject(), callback

# User Object, This proccesses a user db lookup and filters ou to be only public data
user = (user, callback) ->
  this._id = user._id
  this.username = user.username
  this.minecraftUsername = user.minecraftUsername
  this.twitterUsername = user.twitterUsername
  this.gitHubUsername = user.gitHubUsername
  this.website = user.website
  this.realName = user.realName
  this.gravatarhash = md5(user.email or "default-user@theminecraftfiles.com")
  this.href = "http://localhost:3000/user/" + user.username
  callback null, this

# Get all projects with the user set as creator
user::getProjects = (callback) ->
  self = this
  db.project.find {creator:this._id}, (err, projects) ->
    async.map projects, (MongoProjectObject, callback) ->
      new project MongoProjectObject, callback
      #new project MongoProjectObject callback
    , (err, results) ->
      self.projects = results
      callback err, self

# getProject from a projects name
exports.getProject = getProject = (nameIndetifier, callback) ->
  db.project.findOne {name: nameIndetifier}, (err, mongoProjectObject) ->
    callback err if err
    new project mongoProjectObject, callback

# project object
project = (project, callback) ->
  this._id = project._id
  this.name = project.name
  this._creator = project.creator
  this._image = project.image
  this.image =
    src:"/project/" + project.name + "/gallery/" + project.image + ".png" if project.image
  this.description = project.description
  this.image = {}
  this.image.src = "/project/" + project.name + "/gallery/" + project.image + ".png" if project.image
  callback null, this

project::getWatchers = (callback) ->
  # TODO: DB Lookup
  this.watchers = {}
  callback null, this

project::getCreator = (callback) ->
  self = this
  getUser this._creator, (err, user) ->
    callback err if err
    self.creator = user
    callback null, self

project::getWatcherCount = (callback) ->
  # TODO: DB Lookup
  this.watcherCount = 0
  callback null, this

project::getImage = (callback) ->
  # TODO: DB Lookup
  this.watcherCount = 0
  callback null, this


exports.getCategory = getCategory = (categoryIndetifier, callback) ->
  self = this
  db.category.findOne (if (typeof categoryIndetifier is "object") then _id: categoryIndetifier else slug: categoryIndetifier), (err, mongoCategory) ->
    return callback(err, null)  if err
    return callback(null, mongoCategory)  unless mongoCategory
    new category mongoCategory, callback

category = (category, callback) ->
  this._id = category._id
  this.name = category.name
  this.slug = category.slug
  callback null, this

category::getRecent = (callback) ->
  self = this
  db.project.find {category: self._id}, (err, projects) ->
    async.map projects, (MongoProjectObject, callback) ->
      new project MongoProjectObject, callback
      #new project MongoProjectObject callback
    , (err, results) ->
      self.recent = results
      callback err, self

category::getPopular = (callback) ->
  this.popular = {}
  callback null, this

category::getTrending = (callback) ->
  this.trending = {}
  callback null, this


exports.getComments = getComments = (identifier, callback) ->
  console.log identifier
  db.comment.find {}, (err, comments) ->
    next(err) if err

    # Due to issues with mongoose, currently this pulls all comments in and is filtered here to match qeuery
    filteredComments = _.filter comments, (comment) ->
      return true  if comment.identifier.type is identifier.type

    async.map filteredComments, (commentObject, callback) ->
      new comment commentObject, callback
    , (err, results) ->
      return callback err if err
      callback null, results


comment = (object, callback) ->

  getUser object.creator, (err, user) ->
    callback err if err

    callback null,
      _id: object._id
      creator:
        user
      text:
        object.text
      created:
        object.created
      identifier:
        object.identifier


