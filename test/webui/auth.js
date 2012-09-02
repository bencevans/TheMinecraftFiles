var assert = require("assert")


describe('WebUI - Authentication', function(){

	describe('register using username + password', function(){
		it('should return an authenticated session')
	})

	describe('try to register with a username that already exists', function(){
		it('should return with an error')
	})

	describe('try to register with an invalid username', function(){
		it('should return with an error')
	})

	describe('try to register with an invalid password', function(){
		it('should return with an error')
	})

	describe('login using acceptable username + password', function() {
		it('should return an authenticated session')
	})

	describe('login using unacceptable username + password', function() {
		it('should return an with an error')
	})

	describe('after trying to login using unacceptable username + password', function() {
		it('should return ask for a captcha code')
	})
})


