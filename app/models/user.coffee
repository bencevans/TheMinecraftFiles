
module.exports = (sequelize, Sequelize) ->
  return sequelize.define "User",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    username:
      type: Sequelize.STRING
      allowNull: false
      is: ["[a-z|0-9|_|-]"]
      unique: true

    password:
      type: Sequelize.STRING
      allowNull: true # this is so users can just use GitHub auth

    email:
      type: Sequelize.STRING
      allowNull: true
      isEmail: true

    realName:
      type: Sequelize.STRING
      allowNull: true

    minecraftUsername:
      type: Sequelize.STRING
      is: ["^[A-Za-z0-9_]+$"]
      allowNull: true

    website:
      type: Sequelize.STRING
      isURL: true
      allowNull: true

    twitterUsername:
      type: Sequelize.STRING
      is: ["/^[A-Za-z0-9_]+$/"]
      allowNull: true

    gitHubUsername:
      type: Sequelize.STRING
      is: ["/^[A-Za-z0-9_]+$/"]
      allowNull: true

    gitHubID:
      type: Sequelize.INTEGER
      allowNull: true