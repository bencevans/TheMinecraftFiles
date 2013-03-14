
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

###*
 * Relationships
###

User.hasMany Project
Project.belongsTo User

Category.hasMany Project
Project.belongsTo Category


###*
 * Exports
###

module.exports.sequelize = sequelize
module.exports.Sequelize = Sequelize
module.exports.User = User
module.exports.Project = Project
module.exports.Category = Category
