
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



