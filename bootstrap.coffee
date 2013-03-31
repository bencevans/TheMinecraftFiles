###*
 *
 * bootsrap.coffee
 *
 * Sets up connections/config that's generic to any sub-app.
 *
###

###*
 * Dependencies
###

debug = require('debug')('bootstrap')
_ = require 'underscore'
fs = require 'fs'

###*
 * Setup TMF Lib & Connect to DBs
 * @param  {object} config
 * @return {array}        [tmf, db, redisClient]
###

module.exports = (config) ->

  # Setup Redis (Key-Value Store used for storing authenticated sessions)
  #
  # REDISTOGO_URL is the ENVIROMENT variable Heroku (Cloud Web Host) use
  # to provide Redis connection Info.
  if (process.env.REDISTOGO_URL)
    debug('Creating a REDISTOGO Redis Client')
    rtg   = require('url').parse(process.env.REDISTOGO_URL)
    global.redisClient = require('redis').createClient(rtg.port, rtg.hostname)
    global.redisClient.auth(rtg.auth.split(':')[1])
  else
    debug('Creating a local Redis Client')
    global.redisClient = require('redis').createClient()

  global.tmf = null
  global.db = null

  return [null, null, redisClient]
