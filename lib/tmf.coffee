#
# lib/tmf.coffee
#
# This is the library that maps the data in the datbase to objects.
# The objects returned have prototypes (class functions) to provide
# additional info such as if you have a Project object you can call
# Project.getIssues() to return the issues for that project.
#

# Requires
crypto = require 'crypto'
_ = require 'underscore'
async = require 'async'
request = require 'request'
cachey = require 'cachey'

# Helpers
md5 = (string) ->
  crypto.createHash('md5').update(string).digest 'hex'

module.exports = (db, redis) ->
  return new TMF(db, redis)

class TMF

  client = this

  constructor: (@db, @redis) ->

    @cache = cachey {redisClient:@redis}


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
  createUser: (userInfo, callback) ->

    # Check for required attributes.
    if not userInfo.username then callback 'No `username` has been provided'
    if not userInfo.password or not userInfo.gitHubID then callback 'No authenticating attribute has been provided'

    newUser = new db.user(userInfo)

    # Create DB Document
    newUser.save (err, mongoUserObject) ->
      return callback err, mongoUserObject if err

      # Create a user object and it returns to callback with the object.
      new User mongoUserObject, client, callback

  # getUser - get info about a particular user
  getUser: (userIdentifier, callback) ->
    self = this
    self.db.user.findOne (if (typeof userIdentifier is 'object') then _id: userIdentifier else username: userIdentifier), (err, userMongoObject) ->
      return callback(err, null)  if err
      return callback(null, userMongoObject)  unless userMongoObject
      new User userMongoObject.toObject(), client, callback

  # Returns a Project Object given a projects name
  getProject: (nameIndetifier, callback) ->
    db.project.findOne (if (typeof nameIndetifier is 'object') then _id: nameIndetifier else name: nameIndetifier), (err, mongoProjectObject) ->
      callback err if err

      # Return with Null if no Project Exists
      unless mongoProjectObject then return callback null, null

      new Project mongoProjectObject, callback

  getCategory: (categoryIndetifier, callback) ->
    self = this
    db.category.findOne (if (typeof categoryIndetifier is 'object') then _id: categoryIndetifier else slug: categoryIndetifier), (err, mongoCategory) ->
      return callback(err, null)  if err
      return callback(null, mongoCategory)  unless mongoCategory
      new Category mongoCategory, callback

  getComments = (identifier, callback) ->
    db.comment.find {}, (err, comments) ->
      next(err) if err

      # Due to issues with mongoose, currently this pulls all comments in and is filtered here to match qeuery
      filteredComments = _.filter comments, (comment) ->
        return true  if comment.identifier.type is identifier.type

      async.map filteredComments, (commentObject, callback) ->
        new Comment commentObject, callback
      , (err, results) ->
        return callback err if err
        callback null, results

  getTimeline = (projectIdArray, callback) ->
    self = this
    self.db.action.find {project:'$elemMatch':projectIdArray}, (err, actions) ->
      timeline = []
      _.each actions, (actionObject) ->
        new Action actionObject, (err, action) ->
          return callback err if err
          timeline.push action
      self.timeline = timeline
      callback null, self


# User Object, This proccesses a user db lookup and filters ou to be only public data
User = (user, client, callback) ->
  this._id = user._id
  this.username = user.username
  this.minecraftUsername = user.minecraftUsername
  this.twitterUsername = user.twitterUsername
  this.gitHubUsername = user.gitHubUsername
  this.website = user.website
  this.realName = user.realName
  this.gravatarhash = md5(user.email or 'default-user@theminecraftfiles.com')
  this.href = 'http://localhost:3000/user/' + user.username
  this._client = client
  callback null, this

# Get all projects with the user set as creator
User::getProjects = (callback) ->
  self = this
  self._client.db.project.find {creator:this._id}, (err, projects) ->

    # Return with Null if no Projects Exists
    unless projects then callback null, null

    async.map projects, (MongoProjectObject, callback) ->
      new Project MongoProjectObject, callback
      #new project MongoProjectObject callback
    , (err, results) ->
      self.projects = results
      callback err, self

# Finds all projects a user is watching and generates an array at {User Object}.watching
User::getWatching = (callback) ->
  self = this

  self.db.watch.find {user:this._id}, (err, watching) ->
    return callback err if err

    async.map watching, (watch, callback) ->
      self.db.project.findOne ObjectId(watch), (err, projectObject) ->
        new Project projectObject, callback
    , (err, results) ->
      return callback err if err
      self.watching = results
      callback null, self


# Project Class Object
Project = (project, callback) ->
  this._id = project._id
  this.name = project.name
  this.githubRepoURI = project.githubRepoURI
  this._creator = project.creator
  this._image = project.image
  this.image =
    src:'/project/' + project.name + '/gallery/' + project.image + '.png' if project.image
  this.description = project.description
  this.image = {}
  this.image.src = '/project/' + project.name + '/gallery/' + project.image + '.png' if project.image
  callback null, this

# Generates an array of available Downloads for a Project at {Project Object}.downloads
Project::getDownloads = (callback) ->
  self = this

  # self.githubRepoURI = false implies there is no issue provider attached
  if not self.githubRepoURI
    self.githubRepoURI = false
    return callback null, self

  cachey.cache 'githubapi/repos/'+ self.githubRepoURI + '/downloads', 60, (callback) ->
    request 'https://api.github.com/repos/'+ self.githubRepoURI + '/downloads', (err, res, body) ->

      if(!res.statusCode)
        return callback 'Unknown Responce', null

      if res.statusCode == 404
        return callback null, null

      callback null, body

  , (err, body) ->
    return callback err if err

    return callback null, null unless body

    downloads = JSON.parse body

    async.map downloads, (downloadObject, callback) ->
      new Download downloadObject, callback
    , (err, downloads) ->
      return callback err if err

      self.downloads = downloads
      callback null, self

# Generates an array of issues for a Project at {Project Object}.issues
Project::getIssues = (callback) ->
  self = this

  # self.githubRepoURI = false implies there is no issue provider attached
  if not self.githubRepoURI
    self.githubRepoURI = false
    return callback null, self

  cachey.cache 'githubapi/repos/'+ self.githubRepoURI + '/issues', 60, (callback) ->
    request 'https://api.github.com/repos/'+ self.githubRepoURI + '/issues', (err, res, body) ->
      callback err if err

      if res.statusCode == 404
        return callback null, null

      callback null, body
  , (err, body) ->
      return callback err if err

      bodyObject = JSON.parse(body)

      return callback null, null unless bodyObject

      async.map bodyObject, (issueObject, callback) ->
        new Issue issueObject, callback
      , (err, issues) ->
        self.issues = issues
        callback err, self

# Returns an issue given an issued Id
Project::getIssue = (issueId, callback) ->
  self = this

  # self.githubRepoURI = false implies there is no issue provider attached
  if not self.githubRepoURI
    self.githubRepoURI = false
    return callback null, self

  cachey.cache 'githubapi/repos/'+ self.githubRepoURI + '/issues/' + issueId, 60, (callback) ->

    request 'https://api.github.com/repos/'+ self.githubRepoURI + '/issues/' + issueId, (err, res, body) ->
      callback err if err

      if res.statusCode == 404
        return callback null, null

      callback null, body

  , (err, body) ->

    return callback err if err

    bodyObject = JSON.parse(body)

    new Issue bodyObject, callback

# Generates an array of Users watching the Project at {Project Object}.watchers
Project::getWatchers = (callback) ->
  # TODO: DB Lookup
  this.watchers = {}
  callback null, this

# Finds the Creator and adds their User to {Project Object}.creator
Project::getCreator = (callback) ->
  self = this
  getUser this._creator, (err, user) ->
    callback err if err
    self.creator = user
    callback null, self

# Returns a count of Users watching the Project
Project::getWatcherCount = (callback) ->
  self = this
  db.watch.find
    watching: this._id
  .count (err, count) ->
    self.watcherCount = count
    callback err, count

# Returns an Image for the project
Project::getImage = (callback) ->
  # TODO: DB Lookup
  this.watcherCount = 0
  callback null, this

# Generates an array of Events relating to the Project at {Project Object}.timeline
Project::getTimeline = (callback) ->
  self = this
  db.action.find {project:self._id, type:{'$ne':'watch'}}, (err, actions) ->
    timeline = []
    _.each actions, (actionObject) ->
      new Action actionObject, (err, action) ->
        return callback err if err
        timeline.push action
    self.timeline = timeline
    callback null, self

# Sets a User to watch the Project given the User's Id
Project::watch = (userId, callback) ->
  new db.watch
    user: userId
    watching: this._id
  .save callback

# Returns if the User is watching the Project, given their User Id
Project::isWatching = (userId, callback) ->
  db.watch.findOne
    user: userId
    watching: this._id
  , (err, watchObject) ->
    callback err if err
    callback null, (if watchObject then true else false)

# Unwatches the Project given a User Id
Project::unwatch = (userId, callback) ->

  #find rather than findOne just incase multiple watch objects have got through
  db.watch.find(
    user: userId
    project: this._id
  ).remove()

  callback null, true


Category = (category, callback) ->
  this._id = category._id
  this.name = category.name
  this.slug = category.slug
  callback null, this

Category::getRecent = (options,callback) ->
  self = this
  options.skip = (if options.page then options.page - 1 else 0) * options.limit
  db.project.find({category: self._id}).limit(options.limit or 3).skip(options.skip).exec (err, projects) ->
    async.map projects, (MongoProjectObject, callback) ->
      new Project MongoProjectObject, callback
    , (err, results) ->
      self.recent = results
      callback err, self

Category::getPopular = (options, callback) ->
  this.popular = []
  callback null, this

Category::getTrending = (options, callback) ->
  this.trending = []
  callback null, this

Comment = (object, callback) ->

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
    new Action saveObject, callback


Action = (object, callback) ->
  this._id = object._id
  this._actor = object.actor
  this._project = object.project
  this.when = object.when
  this.type = object.type
  this.data = this.data or {}
  callback null, this

Action::getActor = (callback) ->
  self = this

  getUser this._actor, (err, user) ->
    return callback err if err
    self.actor = user
    callback null, self

Action::getProject = (callback) ->
  self = this

  # Return with Null if no Project Exists
  unless this._project then callback null, null

  getProject this._project, (err, project) ->
    if err then callback

    # Return with Null if no Project Exists
    unless project then callback null, null

    self.project = project
    callback null, self

Issue = (object, callback) ->

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


Download = (object, callback) ->

  this._id = object.id
  this._gitHubApiId = object.id
  this._gitHubApiURL = object.url
  this.uploaded = object.created_at
  this.downloadURL = object.html_url
  this.count = object.download_count
  this.name = object.name
  this.description = object.description
  this.size = object.size
  this.download_count = object.download_count
  this.content_type = object.content_type

  callback null, this