
###*
 * Dependencies
###

_ = require 'underscore'
db = require '../../db'

###*
 * Settings Controller
###

module.exports.index = (req, res) ->
    res.redirect '/settings/profile'

module.exports.subPage = (req, res, next) ->
    subPages =
      profile:
        name: 'Profile'
        slug: 'profile'

      account:
        name: 'Account'
        slug: 'account'

    if typeof subPages[req.params.subPage] is 'undefined'
      res.render 'errors/404',
        type: 404

    else

      db.User.find({where:{id: req.user.id}}).success((user) ->
        res.render 'settings/' + req.params.subPage,
          layout: false
          userSettings: user
        , (err, view) ->
          return next(err)  if err
          res.render 'settings',
            title: subPages[req.params.subPage].name
            subPages: _.toArray(subPages)
            subPage:
              view: view
              name: subPages[req.params.subPage].name
              slug: subPages[req.params.subPage].slug
      ).error((error) ->
        next error
      )


module.exports.profile = (req, res, next) ->
    req.user.updateAttributes(req.body).success( ->
      res.redirect '/settings/profile'
    ).error((error) ->
      next error
    )


module.exports.account = (req, res, next) ->

  req.user.updateAttributes(req.body).success( ->
      res.redirect '/settings/account'
    ).error((error) ->
      next error
    )

