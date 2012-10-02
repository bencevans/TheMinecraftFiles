# Requires
crypto = require("crypto")
_ = require 'underscore'
async = require 'async'
request = require 'request'
# Helpers
md5 = (string) ->
  crypto.createHash("md5").update(string).digest "hex"


# db = Object containing all Mongo Models.
db
exports.db = db

# createUser - Creates a User, Saves to DB and returns as a User Object.
#
# userInfo = Object
# Object Attributes should include:
#   - username - String - Remeberable Identifier
#   For identification it should include at least one of the following:
#   - gitHubID - Integer - Numeral GitHub ID Provided from GitHub's OAuth API
#   - password - String
#   Optional:
#   - website - String - URL of Website (Could be GitHub's blog field from OAuth API)
#   + Anything accepted by the User Model.
#
exports.createUser = createUser = (userInfo, callback) ->

  # Check for required attributes.
  if not userInfo.username then callback 'No `username` has been provided'
  if not userInfo.password or not userInfo.gitHubID then callback 'No authenticating attribute has been provided'

  newUser = new db.user(userInfo)

  # Create DB Document
  newUser.save (err, mongoUserObject) ->
    return callback err, mongoUserObject if err

    # Create a user object and it returns to callback with the object.
    new user mongoUserObject, callback

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

    # Return with Null if no Projects Exists
    unless projects then callback null, null

    async.map projects, (MongoProjectObject, callback) ->
      new project MongoProjectObject, callback
      #new project MongoProjectObject callback
    , (err, results) ->
      self.projects = results
      callback err, self

user::getWatching = (callback) ->
  self = this

  db.watch.find {user:this._id}, (err, watching) ->
    return callback err if err

    async.map watching, (watch, callback) ->
      db.project.findOne ObjectId(watch), (err, projectObject) ->
        new project projectObject, callback
    , (err, results) ->
      return callback err if err
      self.watching = results
      callback null, self


# getProject from a projects name
exports.getProject = getProject = (nameIndetifier, callback) ->
  db.project.findOne (if (typeof nameIndetifier is "object") then _id: nameIndetifier else name: nameIndetifier), (err, mongoProjectObject) ->
    callback err if err

    # Return with Null if no Project Exists
    unless mongoProjectObject then return callback null, null

    new project mongoProjectObject, callback

# project object
project = (project, callback) ->
  this._id = project._id
  this.name = project.name
  this.githubRepoURI = project.githubRepoURI
  this._creator = project.creator
  this._image = project.image
  this.image =
    src:"/project/" + project.name + "/gallery/" + project.image + ".png" if project.image
  this.description = project.description
  this.image = {}
  this.image.src = "/project/" + project.name + "/gallery/" + project.image + ".png" if project.image
  callback null, this

project::getIssues = (callback) ->
  self = this

  request 'https://api.github.com/repos/'+ self.githubRepoURI + '/issues', (err, res, body) ->
    callback err if err

    # self.githubRepoURI = false implies there is no issue provider attached
    if not self.githubRepoURI
      self.githubRepoURI = false
      callback null, self

    bodyObject = JSON.parse(body)

    async.map bodyObject, (issueObject, callback) ->
      new issue issueObject, callback
    , (err, issues) ->
      self.issues = issues
      callback err, self

project::getIssue = (issueId, callback) ->
  self = this

  request 'https://api.github.com/repos/'+ self.githubRepoURI + '/issues/' + issueId, (err, res, body) ->
    callback err if err

    # self.githubRepoURI = false implies there is no issue provider attached
    if not self.githubRepoURI
      self.githubRepoURI = false
      return callback null, self

    bodyObject = JSON.parse(body)

    if res.statusCode == 404
      return callback null, null


    new issue bodyObject, callback

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
  self = this
  db.watch.find
    watching: this._id
  .count (err, count) ->
    self.watcherCount = count
    callback err, count


project::getImage = (callback) ->
  # TODO: DB Lookup
  this.watcherCount = 0
  callback null, this

project::getTimeline = (callback) ->
  self = this
  db.action.find {project:self._id, type:{"$ne":'watch'}}, (err, actions) ->
    timeline = []
    _.each actions, (actionObject) ->
      new action actionObject, (err, action) ->
        return callback err if err
        timeline.push action
    self.timeline = timeline
    callback null, self

project::watch = (userId, callback) ->
  new db.watch
    user: userId
    watching: this._id
  .save callback

project::isWatching = (userId, callback) ->
  db.watch.findOne
    user: userId
    watching: this._id
  , (err, watchObject) ->
    callback err if err
    callback null, (if watchObject then true else false)

project::unwatch = (userId, callback) ->

  #find rather than findOne just incase multiple watch objects have got through
  db.watch.find(
    user: userId
    project: this._id
  ).remove()

  callback null, true

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

category::getRecent = (options,callback) ->
  self = this
  options.skip = (if options.page then options.page - 1 else 0) * options.limit
  db.project.find({category: self._id}).limit(options.limit or 3).skip(options.skip).exec (err, projects) ->
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

exports.createAction = createAction = (actionObject, callback) ->
  actionMongoObject = new db.action(actionObject)
  actionMongoObject.save (err, saveObject) ->
    return callback err if err
    new action saveObject, callback


action = (object, callback) ->
  this._id = object._id
  this._actor = object.actor
  this._project = object.project
  this.when = object.when
  this.type = object.type
  this.data = this.data or {}
  callback null, this

action::getActor = (callback) ->
  self = this

  getUser this._actor, (err, user) ->
    return callback err if err
    self.actor = user
    callback null, self

action::getProject = (callback) ->
  self = this

  # Return with Null if no Project Exists
  unless project then callback null, null

  getProject this._project, (err, project) ->
    if err then callback

    # Return with Null if no Project Exists
    unless project then callback null, null

    self.project = project
    callback null, self

exports.getTimeline = getTimeline = (projectIdArray, callback) ->
  self = this
  db.action.find {project:"$elemMatch":projectIdArray}, (err, actions) ->
    timeline = []
    _.each actions, (actionObject) ->
      new action actionObject, (err, action) ->
        return callback err if err
        timeline.push action
    self.timeline = timeline
    callback null, self

issue = (object, callback) ->

  this._id = object.id
  this.title = object.title
  this.assignee = object.assignee
  this.state = object.state
  this.number = object.number
  this.updated_at = object.updated_at
  this.body = object.body
  this.labels = object.labels
  this.user = object.user

  callback null, this