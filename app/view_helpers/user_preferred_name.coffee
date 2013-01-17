
###*
 * Dependencies
###

crypto = require 'crypto'

###*
 * Helpers
###

###*
 * Generate a MD5 HASH of a string
 * @param  {String} string
 * @return {String}        MD5 Hash String
###
md5 = (string) ->
  crypto.createHash('md5').update(string).digest 'hex'

###*
 * Outputs a prefered name from a DB User Object
 * @param  {UserObject}
 * @return {String}             prefered name
###
hbs.registerHelper "user_preferred_name", (userProfile) ->
  return userProfile.realName  if typeof userProfile.realName isnt "undefined"
  userProfile.username

###*
 * gravatar_url
 * @param  {String} gravatarHash/userEmail
 * @param  {Number} size         width of desired image
 * @return {String}              Gravatar Image URL
###
hbs.registerHelper "gravatar_url", (gravatarHash, size) ->
  return false  if typeof gravatarHash isnt "string"
  gravatarHash = md5(gravatarHash) if gravatarHash.match(/@/)
  "http://www.gravatar.com/avatar/" + gravatarHash + "?s=" + size or 140

