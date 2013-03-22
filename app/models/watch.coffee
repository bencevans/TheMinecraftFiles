
module.exports = (sequelize, Sequelize) ->
  return sequelize.define "Watch",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    user:
      type: Sequelize.INTEGER
      required: true

    project:
      type: Sequelize.INTEGER
      required: true