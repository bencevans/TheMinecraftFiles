
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
 * gravatar_url
 * @param  {String} gravatarHash/userEmail
 * @param  {Number} size         width of desired image
 * @return {String}              Gravatar Image URL
###
module.exports = (gravatarHash, size) ->
  return false  if typeof gravatarHash isnt "string"
  gravatarHash = md5(gravatarHash) if gravatarHash.match(/@/)
  return "http://www.gravatar.com/avatar/" + gravatarHash + "?s=" + size or 140

