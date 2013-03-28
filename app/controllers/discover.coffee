
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
        callback(null, _.extend(project.values, {creator: creator, image: image}))
      .error callback
    .error callback


module.exports.index = (req, res, next) ->
  ###
  db.Category.find({id:1}).success (category) ->
    category.getProjects().success (projects) ->
      widgetBuilder projects, (error, projectsWithExtra) ->
        res.send [error, projectsWithExtra]
    .error next
  .error next
  ###
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

  ###
  db.Category.findAll().success (categories) ->
    async.map categories, (category, callback) ->
      console.log 'getting projects for ', category
      category.getProjects
        orderBy: 'createdAt ASC'
        limit: 3
      .success (projects) ->
        widgetBuilder projects, callback
      .error next
    , (error, categories) ->
      console.log 'getting here'
      res.send [error, categories]
  
  #  res.locals.title = 'Discover'

  #  res.render 'discover',
  #    categories: categories
  .error (error) ->
    next error
  ###
module.exports.category = (req, res, next) ->
  db.Category.find(
    slug: req.params.categorySlug
  ).success((category) ->
    unless category then return res.send 404
    category.getProjects(
      limit: 3
      orderBy: 'createdAt'
    ).success((projects) ->
      widgetBuilder projects, (error, projects) ->
        if error then return next error
        res.send projects
    ).error((error) ->
      next error
    )
  ).error (error) ->
    next error

module.exports.category.popular = (req, res, next) ->
  res.send 'Not Here Yet', 404

module.exports.category.recent = (req, res, next) ->
  tmf.getCategory req.params.categorySlug, (err, category) ->
    return next(err)  if err
    unless category
      res.send 404
    else
      category.getRecent {limit:9, page:req.query.page or 1}, (err) ->
        next err if err
        async.map category.recent, (project, callback) ->
          project.getCreator callback
        , (err, results) ->
          res.render 'discover/recent',
            category: category
            title: category.name

module.exports.category.trending = (req, res, next) ->
  res.send 'Not Here Yet', 404
