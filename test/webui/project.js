var assert = require("assert")

describe('WebUI - Project', function(){

	describe('with authorised session', function(){
		it('should return a 404 page to required authorised areas')
		it('should redirect user to login page if public authorised pages (not admin or owner persmissive)')
	})

	describe('create a new acceptable project', function(){
		it('should create the project & redirect to project page')
	})

	describe('attept to create a new project with a name that already exists', function(){
		it('should return with an error')
	})

	describe('attept to create a new project without a name', function(){
		it('should return with an error')
	})

	describe('upload an image to the gallery', function(){
		it('should be visible on the site')
		it('should create a timeline log')
	})

	describe('set an image as default for project', function() {
		it('should mean that all project widgets use that image')
	})

	describe('delete an image', function() {
		it('should double check with user they wish to delete')
		it('should delete file and image gallery record')
	})

	describe('watch a project', function() {
		it('should create timeline log')
		it('should change watch button to unwatch')
	})

	describe('unwatch a project', function() {
		it('should change unwatch button to watch')
	})

})