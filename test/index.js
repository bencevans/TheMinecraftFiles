var fs = require('fs');
var path = require('path');

var uiTests = fs.readdirSync(path.resolve(__dirname, 'webui'));

for (var i = uiTests.length - 1; i >= 0; i--) {
	require(path.resolve(__dirname, 'webui/', uiTests[i]));
};