
LocalStrategy = require('passport-local').Strategy
bcrypt = require "bcrypt"
db = require "../../db"

module.exports = new LocalStrategy (username, password, done) ->

  db.User.find(
    where:
      username: username
  ).success((user) ->
    return done(null, false, 'No User Exists')  unless user
    bcrypt.compare password, user.password, (err, match) ->
      if err or !match then return done(null, false, 'Login failed')
      done null, user
  ).error (error) ->
    done error
