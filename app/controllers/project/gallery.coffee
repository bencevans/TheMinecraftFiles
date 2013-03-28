
###*
 * Dependencies
###

fs = require 'fs'
db = require '../../../db'
async = require 'async'

module.exports.index = (req, res, next) ->
  req.project.getGalleryImages().success (galleryImages) ->
    async.map galleryImages, ((galleryImage, callback) ->
      galleryImage.getFile().success (file) ->
        galleryImage = galleryImage.values
        galleryImage.src = '/project/' + req.project.name + '/gallery/' + galleryImage.id + '.png'
        galleryImage.href = '/project/' + req.project.name + '/gallery/' + galleryImage.id
        callback null, galleryImage
      .error (error) ->
        callback error

    ), (error, results) ->
      if error then return next error
      console.log results
      res.render 'project/gallery',
        layout: false
        galleryImages: results
      , (err, html) ->
        return next(err)  if err
        res.render 'project',
          subPage:
            content: html

  .error (error) ->
    next error


# Route to return Actual Image in PNG Format.
module.exports.imageFile = (req, res, next) ->
  db.GalleryImage.find
    where:
      id:req.params.imageId
  .success (image) ->
    unless image then return res.status(404).render 'errors/404'
    image.getFile().success (file) ->
      res.sendfile file.path
    .error (error) ->
      next error
  .error (error) ->
    next error

# Route to return an individual image gallery page
module.exports.image = (req, res, next) ->
  db.GalleryImage.find
    where:
      id: req.params.imageId
  .success (galleryImage) ->
    unless galleryImage then return next()

    galleryImage = galleryImage.values
    galleryImage.src = '/project/' + req.project.name + '/gallery/' + galleryImage.id + '.png'
    galleryImage.href = '/project/' + req.project.name + '/gallery/' + galleryImage.id
    res.render 'project/gallery/image',
      layout: false
      galleryImage: galleryImage
    , (err, html) ->
      return next(err)  if err
      res.render 'project',
        subPage:
          content: html

  .error next


# Route to set an image to the default project image (Project Owners Only)
module.exports.setDefault = (req, res, next) ->
  return next()  unless req.project.isOwner
  db.project.findById req.project._id, (err, project) ->
    next err if err
    db.galleryImage.findById req.params.imageId, (err, galleryImage) ->
      return next(err) if err
      return res.render 'errors/404', {status: 404} unless galleryImage
      project.update {image:req.params.imageId}, (err, updatedDoc) ->
        next err if err
        res.redirect '/project/' + req.params.projectSlug + "/gallery/" + req.params.imageId

# Route to delete an Image (Project Owners Only)
module.exports.delete = (req, res, next) ->
  res.send req.project.isOwner
  return next()  unless req.project.isOwner
  db.galleryImage.findById(req.params.imageId).populate('file').exec (err, galleryImage) ->
    return next(err)  if err
    unless galleryImage then return next()
    galleryImage.remove (err) ->
      return next(err)  if err
      fs.unlink galleryImage.file.path, (err) ->
        return next(err)  if err
        galleryImage.file.remove (err) ->
          return next(err)  if err
          res.redirect '/project/' + req.params.projectSlug + '/gallery'


# Add an image
module.exports.new = (req, res, next) ->
  return next()  unless req.project.isOwner
  db.File.build
    path: req.files.galleryFileUpload.path
  .save().success (file) ->
    db.GalleryImage.build({}).save().success (galleryImage) ->
      galleryImage.setFile(file).success () ->
        galleryImage.setProject(req.project).success (galleryImage) ->
          res.redirect '/project/' + req.project.name + '/gallery/' + galleryImage.id
        .error (error) ->
          next error
      .error (error) ->
        next error
    .error (error) ->
      next error
  .error (error) ->
    next error

  ###
  upload = new db.file(path: req.files.galleryFileUpload.path)
  upload.save (err, upload) ->
    return next(err)  if err
    galleryImage = new db.galleryImage(
      file: upload._id
      project: req.project._id
    )
    galleryImage.save (err, galleryImage) ->
      return next(err)  if err
      res.redirect '/project/' + req.project.name + '/gallery/' + galleryImage._id

  ###