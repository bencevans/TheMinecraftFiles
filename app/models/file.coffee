
module.exports = (sequelize, Sequelize) ->
  return sequelize.define "File",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    type:
      type: Sequelize.STRING
      allowNull: true

    description:
      type: Sequelize.STRING
      required: true

    path:
      type: Sequelize.STRING
      required: true