
module.exports = (hbs, sys) ->

  hbs.registerHelper "user_preferred_name", (userProfile) ->
    return userProfile.realName  if typeof userProfile.realName isnt "undefined"
    userProfile.username

  hbs.registerHelper "gravatar_url", (gravatarHash, size) ->
    return false  if typeof gravatarHash isnt "string"
    gravatarHash = helpers.md5(gravatarHash)  if gravatarHash.match(/@/)
    "http://www.gravatar.com/avatar/" + gravatarHash + "?s=" + size or 140

