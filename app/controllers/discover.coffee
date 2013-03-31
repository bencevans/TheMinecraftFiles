
###*
 * Dependencies
###

async = require 'async'
_ = require 'underscore'
db = require '../../db'
util = require 'util'

###*
 * Discover Controller
###

###*
 * Helpers
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


module.exports.index = (req, res, next) ->
  db.Category.findAll().success (categories) ->
    async.map categories, (category, callback) ->
      category.getProjects().success (projects) ->
        widgetBuilder projects, (error, projects) ->
          if error then return callback(error)
          callback null, _.extend(category.values, {projects:projects})
      .error callback
    , (error, categories) ->
      res.render 'discover', {categories}
  .error next

module.exports.category = (req, res, next) ->
  db.Category.find(
    where:
      slug: req.params.categorySlug
  ).success((category) ->
    unless category then return res.send 404
    category.getProjects(
      limit: 3
      orderBy: 'createdAt'
    ).success((projects) ->
      widgetBuilder projects, (error, projects) ->
        if error then return next error
        console.log _.extend(category.values, {recent:projects})
        res.render 'discover_category', {category:_.extend(category.values, {recent:projects})}
    ).error((error) ->
      next error
    )
  ).error (error) ->
    next error

module.exports.category.popular = (req, res, next) ->
  # TODO
  res.send 'Not Here Yet', 404

module.exports.category.recent = (req, res, next) ->
  db.Category.find(
    where:
      slug: req.params.categorySlug
  ).success((category) ->
    unless category then return res.send 404
    category.getProjects(
      limit: 3
      orderBy: 'createdAt'
    ).success((projects) ->
      widgetBuilder projects, (error, projects) ->
        if error then return next error
        console.log _.extend(category.values, {recent:projects})
        res.render 'discover/recent', {category:_.extend(category.values, {recent:projects})}
    ).error((error) ->
      next error
    )
  ).error (error) ->
    next error

module.exports.category.trending = (req, res, next) ->
  res.send 'Not Here Yet', 404
