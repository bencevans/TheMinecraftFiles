
module.exports = (everyauth, sys) ->


  everyauth.github.appId(sys.config.auth.github.id).appSecret(sys.config.auth.github.secret).moduleTimeout(8000).findOrCreateUser((session, accessToken, accessTokenExtra, githubUserMetadata) ->
    promise = @Promise()
    sys.db.user.count {
      gitHubID: githubUserMetadata.id
      }, (err, count) ->
      if err
        console.error 'Problem Counting Current User'
        promise.fulfill([err])  if err
      if count is 0
        newUser = new sys.db.user(
          username: githubUserMetadata.login
          gitHubID: githubUserMetadata.id
        )
        newUser.save (err, newUser) ->
          return promise.fulfill([err])  if err
          promise.fulfill newUser
      else
        sys.db.user.findOne
          gitHubID: githubUserMetadata.id
        , (err, user) ->
          return promise.fulfill([err])  if err
          promise.fulfill user


    promise
  ).redirectPath '/'
