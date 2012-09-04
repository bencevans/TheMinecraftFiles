app.get "/discover", (req, res) ->
  db.category.find {}, (err, categories) ->
    return next(err)  if err
    res.locals.title = "Discover"
    res.render "discover",
      categories: categories



app.get "/discover/:categorySlug", (req, res) ->
  tmf.getCategory req.params.categorySlug, (err, category) ->
    return next(err)  if err
    unless category
      res.send 404
    else
      res.render "discover_category",
        category: category
        title: category.name



app.get "/discover/:categorySlug/popular", (req, res) ->
  res.send "Not Here Yet", 404

app.get "/discover/:categorySlug/recent", (req, res) ->
  res.send "Not Here Yet", 404

app.get "/discover/:categorySlug/trending", (req, res) ->
  res.send "Not Here Yet", 404

