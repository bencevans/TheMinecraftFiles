Browser = require('zombie')
assert = require('assert')
request = require('request')
browser = undefined


baseURL = 'http://localhost:3000'

describe 'WebUI', ->

  before (done) ->
    browser = new Browser()
    done()

  after (done) ->
    done()

  describe 'WebUI - Authentication', ->
    describe 'login using good username + password', ->
      it 'should return an authenticated session', (done) ->

        this.timeout 10000

        # Visit Login Page
        browser.visit baseURL + '/login', ->

          # Fill username, password and submit form
          browser.fill('login', 'bencevans').fill('password', 'password').pressButton 'loginsubmit', ->

            # Form submitted, new page loaded.
            assert.ok browser.success
            assert.equal browser.text('title'), 'Timeline | TheMinecraftFiles'
            done()


    describe 'try to register with a username that already exists', ->
      it 'should return with an error', (done) ->
        # Visit Login Page
        browser.visit baseURL + '/register', ->

          # Fill username, password and submit form
          browser.fill('login', 'richard').fill('email', 'john@example.com').fill('password', 'AnAwsomePassword').fill('passwordCheck', 'AnAwsomePassword').pressButton 'registersubmit', ->

            assert.ok browser.success
            #assert.equal browser.text('title'), 'Timeline | TheMinecraftFiles'
            done()

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


  describe 'WebUI - Projects', ->
    describe 'going to a url of a project that doesn\'t exist', ->
      it 'should return a 404 error', (done) ->

        this.timeout 10000

        request baseURL + '/project/someprojecthatdoesntexist', (err, res) ->
          assert.equal null, err
          assert.equal res.statusCode, 404

          done()




