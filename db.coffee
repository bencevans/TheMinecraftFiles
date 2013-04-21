
###*
 * Connection
###

Sequelize = require("sequelize")

if process.env.SQLITE
  options =
    dialect: "sqlite"
    storage: "./db.sqlite"
else
  options = {}

sequelize = new Sequelize "tmf", "root", "sqlpass", options

###*
 * Models
###

User = require("./app/models/user")(sequelize, Sequelize)
Project = require("./app/models/project")(sequelize, Sequelize)
Category = require("./app/models/category")(sequelize, Sequelize)
File = require("./app/models/file")(sequelize, Sequelize)
GalleryImage = require("./app/models/galleryImage")(sequelize, Sequelize)
Download = require("./app/models/download")(sequelize, Sequelize)
Issue = require("./app/models/issue")(sequelize, Sequelize)
Action = require("./app/models/action")(sequelize, Sequelize)
Comment = require("./app/models/comment")(sequelize, Sequelize)

###*
 * Relationships
###

User.hasMany Project
Project.belongsTo User, {as: 'Creator'}

Category.hasMany Project
Project.belongsTo Category

Project.hasMany User, {as: 'Watchers', joinTableName:'Watches'}
User.hasMany Project, {as: 'Watching', joinTableName:'Watches'}

GalleryImage.hasOne File

Project.hasMany GalleryImage
GalleryImage.belongsTo Project

Project.hasOne GalleryImage, {as: 'Image', foreignKey: 'ImageID'}

Project.hasMany Download
Download.belongsTo Project

Project.hasMany Issue
Issue.belongsTo Project

User.hasMany Issue
Issue.belongsTo User

User.hasMany Action
Action.belongsTo User, { as: 'Actor' }

Project.hasMany Action
Action.belongsTo Project

User.hasMany Comment
Comment.belongsTo User


###*
 * Exports
###

module.exports.sequelize = sequelize
module.exports.Sequelize = Sequelize
module.exports.User = User
module.exports.Project = Project
module.exports.Category = Category
module.exports.File = File
module.exports.GalleryImage = GalleryImage
module.exports.Download = Download
module.exports.Issue = Issue
module.exports.Action = Action
module.exports.Comment = Comment
