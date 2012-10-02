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

app.get "/project/:projectSlug/issues/:issueid", (req, res, next) ->
  req.project.getIssue req.params.issueid, (err, issue) ->

    if issue == null
      # Issue doesn't exist
      return res.status(404).render 'errors/404'

    res.locals.issue = issue

    res.render "project/issues/issue",
      layout: false
    , (err, html) ->
      return next(err)  if err
      res.render "project",
        subPage:
          content: html

