
###*
 * Connection
###

Sequelize = require("sequelize")

sequelize = new Sequelize("database", "username", "password",
  dialect: "sqlite"
  storage: "./db.sqlite"
)

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

###*
 * Relationships
###

User.hasMany Project
Project.belongsTo User, {as: 'Creator'}

Category.hasMany Project
Project.belongsTo Category

Project.hasMany User, {as: 'Watchers'}
User.hasMany Project, {as: 'Watching'}

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
