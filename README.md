#TheMinecraftFiles

TheMinecraftFiles is [Ben Evans](http://bensbit.co.uk)'s A Level Computing Project. The aim of the project uis to create a central location to discover, contribute, report issues on [Minecraft](http://minecraft.net) Mods, Themes and Skins.

###Requirements

* NodeJS (0.7+)
* NPM ( 0.6.x )
* MongoDB

###Installation

1. Download Source
2. `npm install`

###Run

1. Make sure MongoDB is running
2. `node server.js` although if your develeoping I'd recomend supervisor (`npm -g install supervisor`, `supervisor server.js`) as it will restart the app everytime a change is made automaticly.