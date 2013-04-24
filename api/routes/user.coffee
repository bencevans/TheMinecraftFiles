
db = require "../../db"

user = (req, res, next) ->

  db.User.find(
    where:
      username: req.params.user
    attributes: [
      "id",
      "username",
      "realName",
      "minecraftUsername",
      "website",
      "twitterUsername",
      "gitHubUsername"
    ]
  ).success((user) ->
    res.send user.values if user
    res.status(404).send message: "User Not Found"
  )


user.projects = (req, res, next) ->
  db.User.find(
    where:
      username: req.params.user
    attributes: ["id"]
  ).success((user) ->
    res.status(404).send message: "User Not Found" unless user
    user.getProjects().success((projects) ->
      res.send projects.values
    ).error(next)
  )

module.exports = user