app.get "/", (req, res) ->
  db.project.find
    creator: req.user._id
  , (err, usersProjects) ->
    return next(err)  if err
    res.locals.title = "Timeline"
    res.render "timeline",
      usersFeedTimeline: []
      usersProjects: usersProjects



