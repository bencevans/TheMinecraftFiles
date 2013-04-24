
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
  unless req.project.isOwner then return next()
  db.GalleryImage.find
    where:
      id: req.params.imageId
  .success (image) ->
    unless image then return next()
    req.project.setImage(image).success ->
      req.flash "Successfully updated the default #{req.project.name} image"
      res.redirect '/project/' + req.params.projectSlug + "/gallery/" + req.params.imageId
    .error next
  .error next

# Route to delete an Image (Project Owners Only)
module.exports.delete = (req, res, next) ->
  return next()  unless req.project.isOwner
  db.GalleryImage.find
    where:
      id: req.params.imageId
  .success (galleryImage) ->
    unless galleryImage then return next()
    galleryImage.getFile().success (file) ->
      file.destroy().success ->
        galleryImage.destroy().success ->
          fs.unlink file.path, (error) ->
            if error then return next error
            res.redirect '/project/' + req.params.projectSlug + "/gallery"
        .error next
      .error next
    .error next
  .error next


# Add an image
module.exports.new = (req, res, next) ->
  return next()  unless req.project.isOwner
  db.File.build
    path: req.files.galleryFileUpload.path
  .save().success (file) ->
    db.GalleryImage.build({}).save().success (galleryImage) ->
      galleryImage.setFile(file).success () ->
        galleryImage.setProject(req.project).success (galleryImage) ->

          # Create Action
          db.Action.build({type:'GalleryUpload', data: galleryImage.id }).save().success((action) ->
            action.setActor(req.user).success((action) ->
              action.setProject(req.project).success((action) ->

                # Redirect User to Gallery Image Page
                res.redirect '/project/' + req.project.name + '/gallery/' + galleryImage.id
              ).error((err) ->
                next err
              )
            ).error (err) ->
              next err
          ).error (err) ->
            next err

        .error (error) ->
          next error
      .error (error) ->
        next error
    .error (error) ->
      next error
  .error (error) ->
    next error