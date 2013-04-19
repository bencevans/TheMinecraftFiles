
module.exports = (sequelize, Sequelize) ->
  return sequelize.define "Action",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    type:
      type: Sequelize.STRING
      allowNull: false

    data:
      type: Sequelize.STRING
      allowNull: true
