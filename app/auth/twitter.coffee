
TwitterStrategy = require("passport-twitter").Strategy
db = require "../../db"

module.exports = new TwitterStrategy
    consumerKey: require("../../config").auth.twitter.key
    consumerSecret: require("../../config").auth.twitter.secret
    callbackURL: require("../../config").auth.twitter.callbackURL
  , (token, tokenSecret, profile, done) ->
    console.log profile
    db.User.findOrCreate
      twitterID: profile.id
      username: profile.username
      realName: profile.displayName
      twitterUsername: profile.username
    .success (user) ->
      unless user then return done(null, false, 'No User Exists')
      done(null, user)
    .error (error) ->
      done error