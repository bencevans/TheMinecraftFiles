everyauth.github.appId("9a5e15b6d6071293280c").appSecret("eb08869d2f61b387222f6494b95069cd1f44e1a5").moduleTimeout(8000).findOrCreateUser((session, accessToken, accessTokenExtra, githubUserMetadata) ->
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
