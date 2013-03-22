
module.exports = (sequelize, Sequelize) ->
  return sequelize.define "Project",
    id:
      type: Sequelize.INTEGER
      primaryKey: true
      autoIncrement: true

    name:
      type: Sequelize.STRING
      allowNull: false
      unique: true
      is: ["/^[a-zA-Z0-9|_|-]+$/"]

    githubRepoURI:
      type: Sequelize.STRING
      is: ["/^[a-zA-Z0-9|-]+\/[a-zA-Z0-9|-]+$/"]
      allowNull: true

    description:
      type: Sequelize.STRING
      allowNull: true