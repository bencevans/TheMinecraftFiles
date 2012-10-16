#TheMinecraftFiles
<hr/>

In this document "Project" relates to any Minecraft Plugin, Theme and/or Skin. 
Also "Package" relates to a downloadable versioned release of a project. A "User" is a person with a registered account. "Public" relates to anyone with/without a registered account.

<hr/>

#Background

Minecraft is a game released by a Swedish developer that goes by the internet name ‘notch’ which features exploration and creativity in a world of blocks.

TheMinecraftFiles is a project requested by the Minecraft playing community in order to centralise the development and news on Mods, Textures and Skins developed by the community.

##Current System
The current system involves a distributed defunct ecosystem of websites hosting in a range of formats from version control systems to an array of ZIP files. There are some sites trying to build up an index of these, however it’s by no means unknown for the original source to then either move the files or remove them hence breaking the indexes.

The following screenshots show some of the project sites and indexes.

![image](http://cl.ly/image/053x362Y431c/Screen%20Shot%202012-09-11%20at%2023.46.38.png)

This site indexes Bukkit (a Minecraft Mod API) only plugins.

![image](http://cl.ly/image/1f0m0H2S1I3X/Screen%20Shot%202012-09-11%20at%2023.48.02.png)

This site is a landing page for a texture pack called 'Tronic'

![image](http://cl.ly/image/2Q1w413f3l3w/Screen%20Shot%202012-09-11%20at%2023.50.17.png)

Another landing page for a Plugin called 'WorldEdit'

Just for a scale of how many projects are already distributed across the internet, a simple Google search of "Minecraft Plugin" returns 6,270,000 Results.

#Objectives

##Social Sign On (GitHub + Twitter)

The website should support Social Sign-on so that when a user wants to open an account their profile can be automatically generated from information they already share on other networks.

This makes the login/register stage a lot faster and it if a user is connected to a network, this can be used for the user to easily 'Share on {network}' which is a free advertisement for the site.

##Project Updates (Timeline)

Much like Twitter's Feed or Facebook's Timeline it should show updates from projects that a user follows. This could be any activity related to the project such as someone opening an issue or creating a new download package.

##Package API

The package API is to be moddled around solutions like NPM (NodeJS Package Manager), Gems (Ruby) etc. It will contain any information a 3rd party application may wish to use about the packages (Project/Plugin/Theme/Skin) real eases.

##Issue Tracking

There should be an optional Issue tracker for each project so users of a project  can report any issues they are having and anyone can answer the issue but only a project owner can mark the issue as closed.

##GitHub Source Code + Issues Integration

GitHub (www.github.com) is a site that hosts code and has it's own issue tracker for each project. GitHub is quite widely used in the Minecraft Project Community however these projects are not indexable.

TheMinecraftFiles should be able to make use of these by using GitHubs API it can access and modify Issues. The code hosting can also be used for example when a "Tag" is pushed to the code repository it could create a new Package/Release/Download on TheMinecraftFiles.

##Discovery

The interface should provide an easy way to discover new projects.

##Authentication Data Encrypted

Any passwords (not IDs) should be encrypted so that if there was a bug or someone managed to gain access to the database they wouldn't/it would be extremely difficult to decrypt/gain access to the original string.

##User Profiles

A User profile should exist with the aim of showing a users participation and own projects. This could be used to generate a karma ranking or something equivalent.

##Scalable

The whole application should be scalable. It should be as fault tolerant as possible but show user friendly errors when required but report all required stack trace information to the developer/logs.

##Search

There should be a search available for users to quickly and easily find content where they know what they are looking for.

##Project Image Galleries

Each project should have an Image Gallery in order to show pictures of the project in action.

##Project Downloads

TheMinecraftFiles should have a page for each project listing all available downloads of the project.

##Embeddable Project Widgets

The application should provide a HTML snippet to be placed on 3rd party websites showing there project's default image, project name and the projects creator.

##OpenGraph Support (User Profiles and Projects)

OpenGraph (http://ogp.me/) is a protocol that's been developed buy Facebook but widely implemented. The protocol shares some basic information such as description of a page, an image to be shown etc. for a page. This can be used so that when a user posts a link to a project or a user to Facebook or many other sites, the project's default image shall show on the 3rd Parties page along with the name and description of the project.

##Commenting/Discussion

There should be a way for any user to 
