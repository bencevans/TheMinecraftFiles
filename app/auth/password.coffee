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
    return promise.fulfill(["No User Exists"])  unless user
    return promise.fulfill(["Login failed"])  if user.password isnt password

    promise.fulfill user

  promise
).getRegisterPath("/register").postRegisterPath("/register").registerView("register.html").registerLocals((req, res, done) ->
  setTimeout (->
    done null,
      title: "Register"

  ), 200
).extractExtraRegistrationParams((req) ->
  user =
    username: req.body.login
    email: req.body.email
    password: req.body.password
    passwordCheck: req.body.passwordCheck

  return user

).validateRegistration((newUserAttrs, errors) ->
  promise = @Promise()

  tmf.getUser newUserAttrs.login, (err, user) ->
    if err then promise.fulfill [err]

    # Check password and the passwordCheck match
    promise.fulfill ["Passwords don't match"] unless newUserAttrs.passwordCheck is newUserAttrs.password

    # OK if no other user is returned
    promise.fulfill true unless user

    # Then user exists so anouther should not be allowed
    promise.fulfill false

  promise
).registerUser((newUserAttrs) ->

  console.log 'newUserAttrs', newUserAttrs

  promise = @Promise()

  tmf.createUser
    username: newUserAttrs.login
    email: newUserAttrs.email
    password: newUserAttrs.password
  , (err, user) ->
    promise.fulfill [err] if err
    promise.fulfill user if err

  promise

).loginSuccessRedirect("/").registerSuccessRedirect "/"
