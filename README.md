# TheMinecraftFiles

TheMinecraftFiles is [Ben Evans](http://bensbit.co.uk)'s A-Level Computing Project. The aim of the project is to create a website to discover, contribute and report issues on [Minecraft](http://minecraft.net) Addons/Plugins (Mods, Texturepacks & Skins).

## Installation

### Databases & Runtimes

OSX (assuming homebrew is installed):

    brew install mongodb redis nodejs

Ubuntu:

    sudo apt-get install python-software-properties
    sudo add-apt-repository ppa:chris-lea/node.js  
    sudo apt-get update
    sudo apt-get install mongodb-server redis-server nodejs

### TheMinecraftFiles

    # Clone code-base
    git clone https://github.com/bencevans/TheMinecraftFiles.git

    # Install modules from [npm](https://npmjs.org)
    npm install

    # Edit ./config.coffee with DB Addreses, GitHub API Secret etc.

    # Setup Database (default Categories etc.)
    ./scripts/setup

### Start & Test

The ./scripts folder houses several helpers:

* `start` Starts the server, mounting the ui and api
* `start-dev` Same as `start` but will restart on any code changes
* `start-cluster` Starts and instance of the server for each core/processor available
* `test` Runs Tests

To run a script exec `./scripts/[script name]`
