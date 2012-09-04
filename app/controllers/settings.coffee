app.get "/settings", (req, res) ->
  res.redirect "/settings/profile"

app.get "/settings/:subPage", (req, res) ->
  subPages =
    profile:
      name: "Profile"
      slug: "profile"

    account:
      name: "Account"
      slug: "account"

  if typeof subPages[req.params.subPage] is "undefined"
    res.render "errors/404",
      type: 404

  else
    db.user.findById req.user._id, (err, userSettings) ->
      res.render "settings/" + req.params.subPage,
        layout: false
        userSettings: userSettings
      , (err, view) ->
        return next(err)  if err
        res.render "settings",
          title: subPages[req.params.subPage].name
          subPages: helpers._.toArray(subPages)
          subPage:
            view: view
            name: subPages[req.params.subPage].name
            slug: subPages[req.params.subPage].slug




app.post "/settings/profile", (req, res) ->
  db.user.update req.user, req.body, (err, user) ->
    return next(err)  if err
    res.redirect "/settings/profile"


app.post "/settings/account", (req, res) ->
  db.user.update req.user, req.body, (err, user) ->
    return next(err)  if err
    res.redirect "/settings/account"


