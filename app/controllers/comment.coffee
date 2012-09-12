
# Controller Dependencies
_ = require 'underscore'

# Route to create a comment
app.post '/comment', (req, res, next) ->

  # Create new Comment Model
  comment = new db.comment(_.extend({creator:req.user._id}, req.body))

  # Save to DB
  comment.save (err) ->
    return next(err) if err
    res.send('saved')
    return res.redirect '/'

# Route to get comments. 
app.get '/comments', (req, res, next) ->

  # Return Error if not enouph parameters are met.
  return res.send error: "Not Enouph Info"  if typeof req.query.identifier is "undefined"

  db.comment.find {}, (err, comments) ->
    next(err) if err

    # Due to issues with mongoose, currently this pulls all comments in and is filtered here to match qeuery
    filteredComments = _.filter comments, (comment) ->
      return true  if comment.identifier.type is req.query.type and comment.identifier.id is req.query.id
      false

      res.send filteredComments