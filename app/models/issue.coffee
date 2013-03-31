
module.exports = (sequelize, Sequelize) ->
  return sequelize.define "Issue",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    title:
      type: Sequelize.STRING
      allowNull: false

    description:
      type: Sequelize.STRING
      allowNull: true

    state:
      type: Sequelize.INTEGER
      default: 1 # 1 = open, #0 = closed, integer rather than bool so other states can be added
