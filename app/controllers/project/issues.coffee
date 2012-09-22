_ = require 'underscore'

app.get "/project/:projectSlug/issues", (req, res, next) ->
  req.project.getIssues (err) ->

    _.each req.project.issues, (issue) ->
      issue.href = '/project/' + req.project.name + '/issues/' + issue.number

    res.render "project/issues",
      layout: false
    , (err, html) ->
      return next(err)  if err
      res.render "project",
        subPage:
          content: html