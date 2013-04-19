
###*
 * Dependencies
###

_ = require 'underscore'
async = require 'async'

###*
 * Project Controller
###

db = require '../../db'

module.exports.all =  (req, res, next) ->

  db.Project.find({where: {name:req.params.project}}).success((project) ->
    unless project then return res.status(404).render('errors/404')
    unless req.params.subPage
      res.redirect '/project/' + req.params.project + '/timeline'
    ###*
     * TODO: Async parrelel
    ###
    project.getCreator().success((creator) ->
      project.getWatchers().success((watches) ->
        res.locals.watcherCount = watches.length
        res.locals.title = project.name
        req.project = res.locals.project = project
        res.locals.subPages = [
          name: 'Timeline'
          slug: 'timeline'
          url: '/project/' + project.name + '/timeline'
        ,
          name: 'Gallery'
          slug: 'gallery'
          url: '/project/' + project.name + '/gallery'
        ,
          name: 'Downloads'
          slug: 'downloads'
          url: '/project/' + project.name + '/downloads'
        ,
          name: 'Issues'
          slug: 'issues'
          url: '/project/' + project.name + '/issues'
        ]
        res.locals.subPage = _.find(res.locals.subPages, (subPage) ->
          if req.params.subPage is subPage.slug
            subPage.current = true
            true
        )
        res.locals.projectCreator = creator
        if req.user and creator and (creator.id is req.user.id)
          project.isOwner = true
          res.locals.isProjectOwner = true

          settingTabId = res.locals.subPages.push
            name: 'Settings'
            slug: 'settings'
            url: '/project/' + project.name + '/settings'
            current: if req.params.subPage is 'settings' then true else false
        if req.user
          res.locals.watching = false
          # TODO: watching
          # req.project.isWatching req.user.id, (err, watching) ->
          #   next err if err
          #   res.locals.watching = watching
        else
          res.locals.watching = false
        next()
      ).error((error) ->
        next error
      )
    ).error((error) ->
      next error
    )
  ).error((error) ->
    next error
  )
