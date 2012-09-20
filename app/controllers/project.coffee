_ = require 'underscore'
async = require 'async'

app.get "/project/:projectSlug", (req, res, next) ->
  res.redirect "/project/" + req.params.projectSlug + "/timeline"

app.all "/project/:projectSlug/:subPage*", (req, res, next) ->

  tmf.getProject req.params.projectSlug, (err, project) ->
    return next(err)  if err
    unless project
      return res.render("errors/404",
        status: 404
      )

    project.getCreator (err) ->
      next err if err

      project.getWatcherCount (err) ->
        next err if err

        res.locals.title = project.name
        req.project = res.locals.project = project
        res.locals.subPages = [
          name: "Timeline"
          slug: "timeline"
          url: "/project/" + project.name + "/timeline"
        ,
          name: "Gallery"
          slug: "gallery"
          url: "/project/" + project.name + "/gallery"
        ,
          name: "Downloads"
          slug: "downloads"
          url: "/project/" + project.name + "/downloads"
        ,
          name: "Issues"
          slug: "issues"
          url: "/project/" + project.name + "/issues"
        ]
        res.locals.subPage = _.find(res.locals.subPages, (subPage) ->
          if req.params.subPage is subPage.slug
            subPage.current = true
            true
        )
        if req.user and project.creator._id.toString() is req.user._id.toString()
          project.isOwner = true
          res.locals.subPages.push
            name: "Settings"
            slug: "settings"
            url: "/project/" + project.name + "/settings"

        if req.user
          req.project.isWatching req.user._id, (err, watching) ->
            next err if err
            res.locals.watching = watching
        else
          res.locals.watching = false
        next()


app.get "/project/:projectSlug/gallery", (req, res, next) ->
  db.galleryImage.find
    project: req.project._id
  , (err, galleryImages) ->
    async.map galleryImages, ((galleryImage, callback) ->
      db.file.findById galleryImage.file, (err, galeryImageFile) ->
        galleryImage = galleryImage.toObject()
        galleryImage.src = "/project/" + req.project.name + "/gallery/" + galleryImage._id + ".png"
        galleryImage.href = "/project/" + req.project.name + "/gallery/" + galleryImage._id
        callback err, galleryImage

    ), (err, results) ->
      return next(err)  if err
      res.render "project/gallery",
        layout: false
        galleryImages: results
      , (err, html) ->
        return next(err)  if err
        res.render "project",
          subPage:
            content: html





