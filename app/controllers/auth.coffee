
# Login Page.
app.get "/login", (req, res) ->
  res.locals.title = "Login"
  if req.loggedIn
    res.redirect "/"
  else
    res.render "login"


#Logout, handled by everyauth along with all login logic.
