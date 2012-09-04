fs = require 'fs'

app.get "/project/:projectSlug/gallery/:imageId.png", (req, res, next) ->
  db.galleryImage.findById req.params.imageId, (err, image) ->
    return next(err)  if err
    unless image
      return res.render("errors/404",
        status: 404
      )
    db.file.findById image.file, (err, file) ->
      res.status(200).sendfile file.path



app.get "/project/:projectSlug/gallery/:imageId", (req, res, next) ->
  db.galleryImage.findById req.params.imageId, (err, galleryImage) ->
    return next(err)  if err
    unless galleryImage
      return res.render("errors/404",
        status: 404
      )
    galleryImage = galleryImage.toObject()
    galleryImage.src = "/project/" + req.project.name + "/gallery/" + galleryImage._id + ".png"
    galleryImage.href = "/project/" + req.project.name + "/gallery/" + galleryImage._id
    res.render "project/gallery/image",
      layout: false
      galleryImage: galleryImage
    , (err, html) ->
      return next(err)  if err
      res.render "project",
        subPage:
          content: html




app.get "/project/:projectSlug/gallery/:imageId/delete", (req, res, next) ->
  return next()  unless req.project.isOwner
  db.galleryImage.findById(req.params.imageId).populate("file").exec (err, galleryImage) ->
    return next(err)  if err
    unless galleryImage
      return res.render("errors/404",
        status: 404
      )
    galleryImage.remove (err) ->
      return next(err)  if err
      fs.unlink galleryImage.file.path, (err) ->
        return next(err)  if err
        galleryImage.file.remove (err) ->
          return next(err)  if err
          res.redirect "/project/" + req.params.projectSlug + "/gallery"





app.post "/project/:projectSlug/gallery", (req, res, next) ->
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
      res.redirect "/project/" + req.project.name + "/gallery/" + galleryImage._id



