

module.exports = (sequelize, Sequelize) ->
  return sequelize.define "Category",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    name:
      type: Sequelize.STRING
      allowNull: false
      unique: true

    slug:
      type: Sequelize.STRING
      allowNull: false
      isLowercase: true
      unique: true
