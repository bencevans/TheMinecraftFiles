assert = require('assert')
describe 'WebUI - Authentication', ->
  describe 'register using username + password', ->
    it 'should return an authenticated session'

  describe 'try to register with a username that already exists', ->
    it 'should return with an error'

  describe 'try to register with an invalid username', ->
    it 'should return with an error'

  describe 'try to register with an invalid password', ->
    it 'should return with an error'

  describe 'login using acceptable username + password', ->
    it 'should return an authenticated session'

  describe 'login using unacceptable username + password', ->
    it 'should return an with an error'

  describe 'after trying to login using unacceptable username + password', ->
    it 'should return ask for a captcha code'


