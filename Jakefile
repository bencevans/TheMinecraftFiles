namespace('setup', function() {

	desc('Setup Default Categories');
	task('categories', ['npm'], function (params) {
		//TODO
	});

	task('npm', function (params) {

		console.log("Installing NPM Modules listed in package.json");

		jake.exec(['npm install'], function () {
			
			console.log("Implementing Quick Fix for GitHub Auth.");

			jake.exec(['curl https://raw.github.com/bnoguchi/everyauth/master/lib/modules/github.js > node_modules/everyauth/lib/modules/github.js'], function () {
				complete();
			}, {printStdout: true})

		}, {printStdout: true, async:false})

	});

});

