usersByLogin = jim:
  login: "jim"
  email: "jim@jimpick.com"
  password: "jim"

everyauth.password.loginWith("login").getLoginPath("/login").postLoginPath("/auth/login").loginView("login.html").loginLocals((req, res, done) ->
  setTimeout (->
    done null,
      title: "Login"

  ), 200
).authenticate((login, password) ->
  errors = []
  errors.push "Missing login"  unless login
  errors.push "Missing password"  unless password
  return errors  if errors.length
  promise = @Promise()
  db.user.findOne
    username: login
  , (err, user) ->
    return promise.fulfill(["Login failed"])  if user.password isnt password
    promise.fulfill user

  promise
).getRegisterPath("/register").postRegisterPath("/register").registerView("register.html").registerLocals((req, res, done) ->
  setTimeout (->
    done null,
      title: "Register"

  ), 200
).extractExtraRegistrationParams((req) ->
  email: req.body.email
).validateRegistration((newUserAttrs, errors) ->
  login = newUserAttrs.login
  errors.push "Login already taken"  if usersByLogin[login]
  errors
).registerUser((newUserAttrs) ->
  login = newUserAttrs[@loginKey()]
  usersByLogin[login] = newUserAttrs
).loginSuccessRedirect("/").registerSuccessRedirect "/"
