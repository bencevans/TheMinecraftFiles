
###*
 * Dependencies
###

async = require 'async'

###*
 * Discover Controller
###

db = require '../../db'

module.exports.index = (req, res, next) ->
  db.Category.findAll().success (categories) ->
    console.log categories
    res.locals.title = 'Discover'
    res.render 'discover',
      categories: categories
  .error (error) ->
    next error

module.exports.category = (req, res, next) ->
  db.Category.find(
    slug: req.params.categorySlug
  ).success((category) ->
    unless category then return res.send 404
    category.getProjects(
      limit: 3
      orderBy: 'createdAt'
    ).success((projects) ->
      res.send ['todo', projects]
      ###
      async.map category.recent, (project, callback) ->
          project.getCreator callback
        , (err, results) ->
          res.render 'discover_category',
            category: category
            title: category.name
      ###
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
