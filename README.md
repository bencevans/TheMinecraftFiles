#Features

* Fast Loding/ on click only updates changed area. Hence transfering less data hence it being quicker (PJAX)

#Installation

###Requirements

* NPM ( 0.6.x )
* MongoDB

###Installation

1. Download Source
2. NPM install
3. Sort everyauth GitHub Module…

Due to no recent NPM release, GitHub have moved to a new version of their API. (GitHubs used as a method of authentication). However it has been updated in the  [Repo](https://github.com/bnoguchi/everyauth/). To fix it replace the content of the file `node_modules/everyauth/lib/modules/github.js` with the content [here](https://github.com/bnoguchi/everyauth/blob/master/lib/modules/github.js). If you need additional help checkout the [comment](https://github.com/bnoguchi/everyauth/issues/259#issuecomment-6913856) I posted to help others online.

###Running

1. Make sure MongoDB is running
2. `node server.js` although if your develeoping I'd recomend supervisor (`npm -g install supervisor`, `supervisor server.js`) as it will restart the app everytime a change is made automaticly.


#External Resources

* jQuery
* PJAX
* Express Library
