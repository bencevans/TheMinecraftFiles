
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
Watch = require("./app/models/watch")(sequelize, Sequelize)
File = require("./app/models/file")(sequelize, Sequelize)
GalleryImage = require("./app/models/galleryImage")(sequelize, Sequelize)

###*
 * Relationships
###

User.hasMany Project
Project.belongsTo User, {as: 'Creator'}

Category.hasMany Project
Project.belongsTo Category

Project.hasMany Watch, {as: 'Watchers'}
User.hasMany Watch, {as: 'Watching'}

GalleryImage.hasOne File

Project.hasMany GalleryImage
GalleryImage.belongsTo Project

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
