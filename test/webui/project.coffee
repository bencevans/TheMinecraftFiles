assert = require('assert')
describe 'WebUI - Project', ->
  describe 'with authorised session', ->
    it 'should return a 404 page to required authorised areas'
    it 'should redirect user to login page if public authorised pages (not admin or owner persmissive)'

  describe 'create a new acceptable project', ->
    it 'should create the project & redirect to project page'

  describe 'attept to create a new project with a name that already exists', ->
    it 'should return with an error'

  describe 'attept to create a new project without a name', ->
    it 'should return with an error'

  describe 'upload an image to the gallery', ->
    it 'should be visible on the site'
    it 'should create a timeline log'

  describe 'set an image as default for project', ->
    it 'should mean that all project widgets use that image'

  describe 'delete an image', ->
    it 'should double check with user they wish to delete'
    it 'should delete file and image gallery record'

  describe 'watch a project', ->
    it 'should create timeline log'
    it 'should change watch button to unwatch'

  describe 'unwatch a project', ->
    it 'should change unwatch button to watch'


