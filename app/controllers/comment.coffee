
###*
 * Dependencies
###

_ = require 'underscore'

###*
 * Comment Controller
###

module.exports = (app, tmf, db) ->

  # Route to create a comment
  create = (req, res, next) ->

    # Create new Comment Model
    comment = new db.comment(_.extend({creator:req.user._id}, req.body))

    # Save to DB
    comment.save (err) ->
      return next(err) if err
      res.send('saved')
      return res.redirect '/'

  # Route to get comments. 
  find = (req, res, next) ->

    # Return Error if not enouph parameters are met.
    return res.send error: 'Not Enouph Info'  if typeof req.query.identifier is 'undefined'

    tmf.getComments
      type: req.query.identifier.type
      id: req.query.identifier.id
    , (err, comments) ->
      next err if err
      res.send comments

  return {create, find}
