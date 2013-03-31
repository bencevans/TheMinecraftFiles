
db = require "../../db"

everyauth.password.loginWith('login').getLoginPath('/login').postLoginPath('/auth/login').loginView('login.html').loginLocals((req, res, done) ->
  setTimeout (->
    done null,
      title: 'Login'

  ), 200
).authenticate((login, password) ->
  errors = []
  errors.push 'Missing login'  unless login
  errors.push 'Missing password'  unless password
  return errors  if errors.length
  promise = @Promise()



  db.User.find
    username: login
  .success (user) ->
    return promise.fulfill(['No User Exists'])  unless user
    return promise.fulfill(['Login failed'])  if user.password isnt password
    promise.fulfill user
  .error (error) ->
    promise.fulfill [error]

  promise
).getRegisterPath('/register').postRegisterPath('/register').registerView('register.html').registerLocals((req, res, done) ->
  setTimeout (->
    done null,
      title: 'Register'

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

  promise.fulfill ['Passwords don\'t match'] unless newUserAttrs.passwordCheck is newUserAttrs.password

  db.User.find(
    where:
      username: newUserAttrs.login
  ).success((user) ->

    # OK if no other user is returned
    promise.fulfill true unless user

    # Then user exists so anouther should not be allowed
    promise.fulfill false

  ).error((error) ->
    promise.fulfill [error]
  )


  promise
).registerUser((newUserAttrs) ->

  console.log 'newUserAttrs', newUserAttrs

  promise = @Promise()

  db.User.build(
    username: newUserAttrs.login
    email: newUserAttrs.email
    password: newUserAttrs.password
  ).save().success (user) ->
    promise.fulfill user
  .error (error) ->
    promise.fulfill [error]

  promise

).loginSuccessRedirect('/').registerSuccessRedirect '/'
