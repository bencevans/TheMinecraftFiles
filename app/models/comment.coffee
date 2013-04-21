module.exports = (sequelize, Sequelize) ->
  return sequelize.define "Comment",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    text:
      type: Sequelize.STRING
      allowNull: false

    identifierType:
      type: Sequelize.STRING
      allowNull: false
      isLowercase: true

    identifierId:
      type: Sequelize.STRING
      allowNull: false
      isLowercase: true

