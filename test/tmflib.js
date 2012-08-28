var assert = require("assert")
var path = require('path');
var tmfLib = require(path.resolve(__dirname, '../lib/tmf.js'));

config = {mongo:{uri:'mongodb://localhost/TheMinecraftFilesTEST'}};
require(path.resolve(__dirname, '../bootstrap.js'));

var testUser = new db.user({
	username: 'johnsmith',
});

var testCategory = new db.category({
	name:'Mods',
	slug:'mods'
})

describe('tmfLib', function(){

	var tmf;

	before(function(done){
		testUser.save(function (err) {
			if(err)
				console.log(err);
			done();
		});
	})

	after(function(done){
		testUser.remove();
		done();
	})

	describe('#createInterface()', function(){
		it('should return an Interface instance', function(){
			tmf = tmfLib.createInterface(db);
			assert.equal(typeof tmf, "object");
		})
	})

	

	describe('#getUser()', function(){
		it('should return a valid user object on username', function (done){
			tmf.getUser(testUser.username, function (err, user) {
				assert.equal(err, null);
				assert.notEqual(null,user._id.toString())
				assert.equal(testUser._id.toString(),user._id.toString())
				done();
			})
		})
		it('should return a valid user object on objectID', function (done){
			tmf.getUser(testUser._id, function (err, user) {
				assert.equal(err, null);
				assert.notEqual(null,user._id.toString())
				assert.equal(testUser._id.toString(),user._id.toString())
				done();
			})
		})
		it('should resolve .projects to objects', function (done) {
			tmf.getUser(testUser.username, function (err, user) {
				assert.equal(err, null);
				assert.notEqual(typeof user.projects,"string")
				done();
			})
		})
	})

	describe('#getCategory()', function(){
		it('should return an valid category object')
		it('should resolve projects and project owners/creators')
	})

	describe('#getProject()', function(){
		it('should return an valid project object')
		it('should resolve projects owners/creators')
	})
})


