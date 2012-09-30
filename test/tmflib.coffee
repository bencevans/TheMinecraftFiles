assert = require("assert")
path = require("path")
global.config = mongo:
  uri: "mongodb://localhost/TheMinecraftFilesTEST"

require path.resolve(__dirname, "../bootstrap")


testUser = new db.user(
  username: "johnsmith"
)

testCategory = new db.category(
  name: "Mods"
  slug: "mods"
)

testProject = new db.project(
  name: "Tronic"
  slug: "Ttronic"
)

describe "tmfLib", ->
  tmf = require(path.resolve(__dirname, "../lib/tmf"))
  tmf.db = global.db

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




  describe "#getUser()", ->
    it "should return a valid user object on username", (done) ->
      tmf.getUser testUser.username, (err, user) ->
        assert.equal err, null
        assert.notEqual null, user._id.toString()
        assert.equal testUser._id.toString(), user._id.toString()
        done()


    it "should return a valid user object on objectID", (done) ->
      tmf.getUser testUser._id, (err, user) ->
        assert.equal err, null
        assert.notEqual null, user._id.toString()
        assert.equal testUser._id.toString(), user._id.toString()
        done()


    it "should resolve .projects to objects", (done) ->
      tmf.getUser testUser.username, (err, user) ->
        assert.equal err, null
        assert.notEqual typeof user.projects, "string"
        done()



  describe "#getCategory()", ->
    it "should return an valid category by slug", (done) ->
      tmf.getCategory testCategory.slug, (err, category) ->
        assert.equal err, null
        assert.notEqual category, null
        assert.equal typeof category, "object"
        assert.equal category._id.toString(), testCategory._id.toString()
        done()


    it "should return an valid category by objectID", (done) ->
      tmf.getCategory testCategory._id, (err, category) ->
        assert.equal err, null
        assert.notEqual category, null
        assert.equal typeof category, "object"
        assert.equal category._id.toString(), testCategory._id.toString()
        done()


    it "should resolve projects and project owners/creators"

  describe "#getProject()", ->
    it "should return a valid project object by ObjectID", (done) ->
      tmf.getProject testProject._id, (err, project) ->
        assert.equal err, null
        assert.notEqual project, null
        assert.equal typeof project, "object"
        assert.equal project._id.toString(), testProject._id.toString()
        done()



