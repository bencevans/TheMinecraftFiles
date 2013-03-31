_ = require 'underscore'
db = require '../../../db'

module.exports.index = (req, res, next) ->
  req.project.getIssues().success (issues) ->
    issues = issues.values
    _.each issues, (issue) ->
      issue.href = '/project/' + req.project.name + '/issues/' + issue.number

    res.render 'project/issues',
      layout: false
      issues: issues
    , (err, html) ->
      return next(err)  if err
      res.render "project",
        subPage:
          content: html

  .error next

module.exports.issue = (req, res, next) ->

  db.Issue.find(
    where:
      ProjectID: req.project.id
      id: req.params.issueid
  ).success (issue) ->
    if(!issue) then return next()
    res.render 'project/issues/issue',
      layout: false
      issue: issue
    , (err, html) ->
      return next(err)  if err
      res.render 'project',
        subPage:
          content: html
  .error next
