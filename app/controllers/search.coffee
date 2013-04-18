
util = require "util"
async = require "async"
_ = require "underscore"

db = require "../../db"

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

module.exports.results = (req, res, next) ->

  if(!req.query.q)
    return next(new Error('No query provided'));

  db.Project.findAll
    where:
      ["name like ? OR description like ?", '%' + req.query.q + '%', '%' + req.query.q + '%']
  .success (projects) ->
    widgetBuilder projects, (error, projectsWithExtras) ->
      if error then return next(error)
      res.render "search",
        projects: projectsWithExtras
        searchQuery: req.query.q
  .error (error) ->
    next error