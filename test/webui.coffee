Browser = require("zombie")
assert = require("assert")
browser = undefined


baseURL = 'http://localhost:3000'

describe "WebUI", ->

  before (done) ->
    browser = new Browser()
    done()

  after (done) ->
    done()

  describe "WebUI - Authentication", ->
    describe "login using good username + password", ->
      it "should return an authenticated session", (done) ->

        this.timeout 10000

        # Visit Login Page
        browser.visit baseURL + "/login", ->

          # Fill username, password and submit form
          browser.fill("login", "bencevans").fill("password", "password").pressButton "loginsubmit", ->

            # Form submitted, new page loaded.
            assert.ok browser.success
            assert.equal browser.text("title"), "Timeline | TheMinecraftFiles"
            done()


    describe "try to register with a username that already exists", ->
      it "should return with an error"

    describe "try to register with an invalid username", ->
      it "should return with an error"

    describe "try to register with an invalid password", ->
      it "should return with an error"

    describe "login using acceptable username + password", ->
      it "should return an authenticated session"

    describe "login using unacceptable username + password", ->
      it "should return an with an error"

    describe "after trying to login using unacceptable username + password", ->
      it "should return ask for a captcha code"






