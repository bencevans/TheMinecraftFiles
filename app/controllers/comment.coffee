
###*
 * Dependencies
###

_ = require 'underscore'
db = require '../../db'
async = require 'async'
crypto = require 'crypto'

###*
 * Helpers
###

###*
 * Generate a MD5 HASH of a string
 * @param  {String} string
 * @return {String}        MD5 Hash String
###
md5 = (string) ->
  crypto.createHash('md5').update(string).digest 'hex'

###*
 * Comment Controller
###

# Route to create a comment
module.exports.create = (req, res, next) ->

  # Create new Comment Model
  req.body.identifierType = req.body.identifier.type
  req.body.identifierId = req.body.identifier.id
  comment = db.Comment.build(_.extend({creator:req.user.id}, req.body))

  # Save to DB
  comment.save().success((comment) ->
    comment.setUser(req.user).success(->
      res.send 'saved'
    ).error(next)
  ).error(next)

# Route to get comments. 
module.exports.find = (req, res, next) ->

  # Return Error if not enouph parameters are met.
  return res.send error: 'Not Enouph Info'  if typeof req.query.identifier is 'undefined'

  db.Comment.findAll(
    where:
      identifierType: req.query.identifier.type
      identifierId: req.query.identifier.id
    order: 'createdAt DESC'
  ).success((comments) ->
    async.map comments, (comment, done) ->
      comment.getUser(attributes: ['username', 'realName', 'email']).success((creator) ->
        creator = creator.values
        creator.gravatarhash = md5(creator.email)
        creator.email = undefined
        done(null, _.extend(comment.values, {creator:creator}))
      ).error(done)
    , (err, commentsWithCreator) ->
      res.send commentsWithCreator
  ).error(next)

