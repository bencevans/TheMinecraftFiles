everyauth.github.appId(config.auth.github.id).appSecret(config.auth.github.secret).moduleTimeout(8000).findOrCreateUser((session, accessToken, accessTokenExtra, githubUserMetadata) ->
  promise = @Promise()
  db.user.count {}, (err, count) ->
    if err
      console.error "Problem Counting Current User"
      return false
    if count is 0
      newUser = new db.user(
        username: githubUserMetadata.login
        gitHubID: githubUserMetadata.id
      )
      newUser.save (err) ->
        return false  if err
        promise.fulfill newUser

    else
      db.user.findOne
        gitHubID: githubUserMetadata.id
      , (err, user) ->
        return promise.fulfill([err])  if err
        promise.fulfill user


  promise
).redirectPath "/"
