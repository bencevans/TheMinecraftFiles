
db = require "../../db"

module.exports = (req, res, next) ->

  db.Project.find(
    where:
      name: req.params.project
  ).success((project) ->
    unless project
      res.status 404
      return res.send(message: "Project Not Found")
    res.send project

  ).error(next)

  tmf.getProject req.params.project, (err, project) ->
    return next(err)  if err
    unless project
      res.status 404
      return res.send(message: "Project Not Found")
    project.getImage (err) ->
      project.getCreator (err) ->
        return next(err)  if err
        res.send project