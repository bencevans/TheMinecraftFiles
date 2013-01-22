
###*
 * Dependencies
###

assert = require('assert')
path = require('path')
async = require('async')
_ = require('underscore')

###*
 * Setup Client/Bootstrap
###

config = mongo:
  uri: 'mongodb://localhost/TheMinecraftFilesTEST'

[tmf, db, redisClient] = require('../bootstrap')(config)


###*
 * Test Objects
###

testUser = new db.user(
  username: 'johnsmith'
)

testCategory = new db.category(
  name: 'Mods'
  slug: 'mods'
)

testProject = new db.project(
  name: 'Tronic'
  slug: 'Ttronic'
)

###*
 * Start Tests
###

describe 'tmfLib', ->

  before (done) ->

    this.timeout 10000
    testUser.save (err) ->
      return done(err) if err
      testCategory.save (err) ->
        return done(err) if err
        testProject.save (err) ->
          done err


  after (done) ->
    testUser.remove()
    testCategory.remove()
    testProject.remove()
    done()


  describe '#getUser()', ->
    it 'should return a valid user object on username', (done) ->
      tmf.getUser testUser.username, (err, user) ->
        assert.equal err, null
        assert.notEqual null, user._id.toString()
        assert.equal testUser._id.toString(), user._id.toString()
        done()


    it 'should return a valid user object on objectID', (done) ->
      tmf.getUser testUser._id, (err, user) ->
        assert.equal err, null
        assert.notEqual null, user._id.toString()
        assert.equal testUser._id.toString(), user._id.toString()
        done()


    it 'should resolve .projects to objects', (done) ->
      tmf.getUser testUser.username, (err, user) ->
        assert.equal err, null
        assert.notEqual typeof user.projects, 'string'
        done()


  describe '#getCategory()', ->
    it 'should return an valid category by slug', (done) ->
      tmf.getCategory testCategory.slug, (err, category) ->
        assert.equal err, null
        assert.notEqual category, null
        assert.equal typeof category, 'object'
        assert.equal category._id.toString(), testCategory._id.toString()
        done()


    it 'should return a valid category by objectID', (done) ->
      tmf.getCategory testCategory._id, (err, category) ->
        assert.equal err, null
        assert.notEqual category, null
        assert.equal typeof category, 'object'
        assert.equal category._id.toString(), testCategory._id.toString()
        done()


    it '#getRecent, #getTrending and #getPopular should resolve appropriate arrays on object', (done) ->
      tmf.getCategory testCategory._id, (err, category) ->
        assert.equal null, err
        assert.notEqual null, category

        async.map _.keys(category.__proto__), (funcName, callback) ->
          category[funcName] {}, callback

        , (err) ->
          return done(err) if err

          assert.equal true, _.isArray category.recent
          assert.equal true, _.isArray category.trending
          assert.equal true, _.isArray category.popular
          done()

  describe '#getProject()', ->
    it 'should return a valid project object by ObjectID', (done) ->
      tmf.getProject testProject._id, (err, project) ->
        assert.equal err, null
        assert.notEqual project, null
        assert.equal typeof project, 'object'
        assert.equal project._id.toString(), testProject._id.toString()
        done()



