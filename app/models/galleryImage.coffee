
module.exports = (sequelize, Sequelize) ->
  return sequelize.define "GalleryImage",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    name:
      type: Sequelize.STRING
      allowNull: true
      is: ["/^.{0,12}$/"]

    description:
      type: Sequelize.STRING
      allowNull: true