assert = require("assert")
path = require("path")
tmfLib = require(path.resolve(__dirname, "../lib/tmf"))
global.config = mongo:
  uri: "mongodb://localhost/TheMinecraftFilesTEST"

require path.resolve(__dirname, "../bootstrap")
testUser = new db.user(username: "johnsmith")
testCategory = new db.category(
  name: "Mods"
  slug: "mods"
)
describe "tmfLib", ->
  tmf = undefined
  before (done) ->
    testUser.save (err) ->
      return done(err)  if err
      testCategory.save (err) ->
        done err



  after (done) ->
    testUser.remove()
    testCategory.remove()
    done()

  describe "#createInterface()", ->
    it "should return an Interface instance", ->
      tmf = tmfLib.createInterface(db)
      assert.equal typeof tmf, "object"


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
    it "should return an valid project object"
    it "should resolve projects owners/creators"


