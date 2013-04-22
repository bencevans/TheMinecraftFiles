
db = require '../../../db'

module.exports.index = (req, res, next) ->

  req.project.getDownloads().success (err, downloads) ->
    console.log(downloads)
    res.render 'project/downloads',
      layout: false
      downloads: downloads
    , (err, html) ->
      return next(err)  if err
      res.render 'project',
        subPage:
          content: html
  .error(next)

module.exports.new = (req, res, next) ->
  return next() unless req.project.isOwner
  res.render('project/downloads/new')

# Add a download
module.exports.newAction = (req, res, next) ->
  return next() unless req.project.isOwner
  db.File.build
    path: req.files.file.path
  .save().success (file) ->
    db.Download.build(req.body).save().success (download) ->
      download.setFile(file).success () ->
        download.setProject(req.project).success (download) ->
          res.redirect '/project/' + req.project.name + '/downloads/' + download.id
        .error (error) ->
          next error
      .error (error) ->
        next error
    .error (error) ->
      next error
  .error (error) ->
    next error