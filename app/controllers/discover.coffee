
async = require 'async'

app.get "/discover", (req, res, next) ->
  db.category.find {}, (err, categories) ->
    return next(err)  if err
    res.locals.title = "Discover"
    res.render "discover",
      categories: categories



app.get "/discover/:categorySlug", (req, res, next) ->
  tmf.getCategory req.params.categorySlug, (err, category) ->
    return next(err)  if err
    unless category
      res.send 404
    else
      category.getRecent {limit:3, page:1}, (err) ->
        next err if err
        async.map category.recent, (project, callback) ->
          project.getCreator callback
        , (err, results) ->

          res.render "discover_category",
            category: category
            title: category.name



app.get "/discover/:categorySlug/popular", (req, res, next) ->
  res.send "Not Here Yet", 404

app.get "/discover/:categorySlug/recent", (req, res, next) ->
  tmf.getCategory req.params.categorySlug, (err, category) ->
    return next(err)  if err
    unless category
      res.send 404
    else
      category.getRecent {limit:9, page:req.query.page or 1}, (err) ->
        next err if err
        async.map category.recent, (project, callback) ->
          project.getCreator callback
        , (err, results) ->
          res.render "discover/recent",
            category: category
            title: category.name

app.get "/discover/:categorySlug/trending", (req, res, next) ->
  res.send "Not Here Yet", 404

