#
#
#dashboard.timeline
#
#users.profile :username
#users.projects :username
#users.watching
#users.following
#users.update :username? {name:"New Name"}
#
#projects.overview :projectName
#projects.update :projectName? {website:"http://projectssite.com"}
#projects.members :projectName
#
#issues.overiew :projectName {paginationOptions etc.}
#issues.new :projectName {}
#
#
md5 = (string) ->
  crypto.createHash("md5").update(string).digest "hex"
async = require("async")
crypto = require("crypto")
_ = require("underscore")

# db = pbject containing all Mongo Models.
exports.createInterface = (db) ->
  new Interface(db)

Interface = (db) ->
  @db = db
  this

Interface::getUser = (userIdentifier, callback) ->
  self = this
  self.db.user.findOne (if (typeof userIdentifier is "object") then _id: userIdentifier else username: userIdentifier), (err, user) ->
    return callback(err, null)  if err
    return callback(null, user)  unless user
    self.db.project.find
      creator: user._id
    , (err, projects) ->
      return callback(err)  if err
      returnUser = user.toObject()
      returnUser.projects = projects
      returnUser.gravatarhash = md5(returnUser.email or "default-user@theminecraftfiles.com")
      _.each returnUser.projects, (project) ->
        project.creator.username = returnUser.username

      callback null, returnUser



Interface::getCategory = (categoryIndetifier, callback) ->
  self = this
  self.db.category.findOne (if (typeof categoryIndetifier is "object") then _id: categoryIndetifier else slug: categoryIndetifier), (err, category) ->
    return callback(err, null)  if err
    return callback(null, category)  unless category
    async.parallel [(callback) ->
      
      # Gather Popular
      callback null, null
    , (callback) ->
      
      # Gather Recent
      self.db.project.find(category: category._id).populate("creator", "username").exec callback
    , (callback) ->
      
      # Gather Trending
      callback null, null
    ], (err, results) ->
      return callback(err)  if err
      returnCategory = category
      returnCategory.popular = results[0]
      returnCategory.recent = results[1]
      returnCategory.trending = results[2]
      callback null, returnCategory



Interface::getProject = (nameIndetifier, callback) ->
  self = this
  self.db.project.findOne
    name: nameIndetifier
  , (err, project) ->
    return callback(err, null)  if err
    return callback(null, project)  unless project
    self.getUser project.creator, (err, creator) ->
      return callback(err, null)  if err
      return callback(null, project)  unless creator
      returnProject = project.toObject()
      returnProject.creator = creator
      callback null, returnProject


