
db = require "../../db"

everyauth.github.appId(config.auth.github.id).appSecret(config.auth.github.secret).moduleTimeout(80000).findOrCreateUser((session, accessToken, accessTokenExtra, githubUserMetadata) ->
  promise = @Promise()
  console.log "start search"
  db.User.find(
    where:
      gitHubID: githubUserMetadata.id
  ).success((user) ->
    console.log "found user:", user
    if user then return promise.fulfill user
    console.log "creating user!"
    db.User.build(
      username: githubUserMetadata.login
      gitHubID: githubUserMetadata.id
    ).save().success((user) ->
      console.log "1"
      return promise.fulfill user
    ).error (error) ->
      console.log "2"
      console.log error
      return promise.fulfill [error]
  ).error (error) ->
    console.log "3"
    return promise.fulfill [error]

  return promise
).redirectPath '/'
