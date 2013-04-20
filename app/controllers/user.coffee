
###*
 * Dependencies
###

async = require 'async'
db = require '../../db'
_ = require 'underscore'
util = require 'util'

###*
 * User Controller
###

widgetBuilder = (project, callback) ->
  if util.isArray(project)
    async.map project, widgetBuilder, callback
  else
    project.getCreator({attributes: ['username', 'id', 'realName']}).success (creator) ->
      project.getImage().success (image) ->
        if image
          image.getFile().success (file) ->
            console.log file
            callback(null, _.extend(project.values, {creator: creator, image: _.extend(image.values, {src: "/project/#{project.name}/gallery/#{image.id}.png"})}))
          .error callback
        else
          callback(null, _.extend(project.values, {creator: creator, image: image}))
      .error callback
    .error callback


module.exports.profile = (req, res, next) ->

  db.User.find({where: {username:req.params.username}}).success((user) ->
    unless user then return res.status(404).render('errors/404')
    res.locals.title = user.username
    user.getProjects().success((projects) ->
      widgetBuilder projects, (error, projects) ->
        if error then return next error
        res.render 'user',
          profile: _.extend(user.values, {projects: projects})
    ).error((error) ->
      next error
    )
  ).error((error) ->
    next error
  )



