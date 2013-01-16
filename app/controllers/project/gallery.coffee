fs = require 'fs'

module.exports = (app, sys) ->

  # Route to return Actual Image in PNG Format.
  app.get '/project/:projectSlug/gallery/:imageId.png', (req, res, next) ->
    db.galleryImage.findById req.params.imageId, (err, image) ->
      return next(err)  if err
      unless image
        return res.render 'errors/404',
          status: 404
      db.file.findById image.file, (err, file) ->
        res.status(200).sendfile file.path


  # Route to return an individual image gallery page
  app.get '/project/:projectSlug/gallery/:imageId', (req, res, next) ->
    db.galleryImage.findById req.params.imageId, (err, galleryImage) ->
      return next(err)  if err
      unless galleryImage
        return res.render 'errors/404',
          status: 404
      galleryImage = galleryImage.toObject()
      galleryImage.src = '/project/' + req.project.name + '/gallery/' + galleryImage._id + '.png'
      galleryImage.href = '/project/' + req.project.name + '/gallery/' + galleryImage._id
      res.render 'project/gallery/image',
        layout: false
        galleryImage: galleryImage
      , (err, html) ->
        return next(err)  if err
        res.render 'project',
          subPage:
            content: html

  # Route to set an image to the default project image (Project Owners Only)
  app.get '/project/:projectSlug/gallery/:imageId/default', (req, res, next) ->
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
  app.get '/project/:projectSlug/gallery/:imageId/delete', (req, res, next) ->
    return next()  unless req.project.isOwner
    db.galleryImage.findById(req.params.imageId).populate('file').exec (err, galleryImage) ->
      return next(err)  if err
      unless galleryImage
        return res.render('errors/404',
          status: 404
        )
      galleryImage.remove (err) ->
        return next(err)  if err
        fs.unlink galleryImage.file.path, (err) ->
          return next(err)  if err
          galleryImage.file.remove (err) ->
            return next(err)  if err
            res.redirect '/project/' + req.params.projectSlug + '/gallery'


  # Displays an overview of all images in gallery
  app.post '/project/:projectSlug/gallery', (req, res, next) ->
    return next()  unless req.project.isOwner
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



