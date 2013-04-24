
GitHubStrategy = require('passport-github').Strategy
db = require "../../db"

module.exports = new GitHubStrategy
    clientID: require("../../config").auth.github.id
    clientSecret: require("../../config").auth.github.secret
    callbackURL: require("../../config").auth.github.callbackURL
  , (accessToken, refreshToken, profile, done) ->
    db.User.findOrCreate
      gitHubID: profile.id
      username: profile.username
      realName: profile.displayName
      gitHubUsername: profile.username
    .success (user) ->
      unless user then return done(null, false, 'No User Exists')
      done(null, user)
    .error (error) ->
      done error
