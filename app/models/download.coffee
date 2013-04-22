

module.exports = (sequelize, Sequelize) ->
  return sequelize.define "Download",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    name:
      type: Sequelize.STRING
      allowNull: false

    description:
      type: Sequelize.STRING
      allowNull: true
      unique: true

    count:
      type: Sequelize.INTEGER
      default: 0
