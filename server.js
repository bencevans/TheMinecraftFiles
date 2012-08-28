var express = require('express'),
stylus = require('stylus'),
fs = require('fs'),
redisStore = require('connect-redis')(express),
crypto = require('crypto');
var hbs = require('hbs');

app = express();
var flashify = require('flashify');
_ = require('underscore');
config = {mongo:{}}
//Bootstrap (DB Etc.)
require('./bootstrap.js')

tmflib = require('./lib/tmf.js')
tmf= tmflib.createInterface(db);


// Authentication Requirements
var everyauth = require('everyauth');
everyauth.github
.appId('9a5e15b6d6071293280c')
.appSecret('eb08869d2f61b387222f6494b95069cd1f44e1a5')
.moduleTimeout( 8000 )
.findOrCreateUser( function (session, accessToken, accessTokenExtra, githubUserMetadata) {

	var promise = this.Promise();



	db.user.count({}, function (err, count) {

		if(err){
			console.error('Problem Counting Current User');
			return false;
		}

		if(count === 0) {

			var newUser = new db.user({
				username: githubUserMetadata.login,
				gitHubID: githubUserMetadata.id
			});
			newUser.save(function (err) {
				if(err)
					return false;
				promise.fulfill(newUser);
			});




		} else {

			db.user.findOne({ gitHubID: githubUserMetadata.id}, function (err, user) {
				if (err) return promise.fulfill([err]);
				promise.fulfill(user);
			});

		}
	});

	return promise;
})
.redirectPath('/');

var usersByLogin = {
	'jim': {
		login: 'jim',
		email: 'jim@jimpick.com'
		, password: 'jim'
	}
};


everyauth
.password
    .loginWith('login')
    .getLoginPath('/login')
    .postLoginPath('/auth/login')
    .loginView('login.html')
    .loginLocals( function (req, res, done) {
        setTimeout( function () {
    		done(null, {
    			title: 'Login'
    		});
    	}, 200);
    })
    .authenticate( function (login, password) {
    	var errors = [];
    	if (!login) errors.push('Missing login');
    	if (!password) errors.push('Missing password');
    	if (errors.length) return errors;

    	var promise = this.Promise();

    	db.user.findOne({username:login}, function(err, user) {
    		if (user.password !== password) return promise.fulfill(['Login failed']);
    		promise.fulfill(user);
    	})

    	return promise;
    })

    .getRegisterPath('/register')
    .postRegisterPath('/register')
    .registerView('register.html')
    .registerLocals( function (req, res, done) {
    	setTimeout( function () {
    		done(null, {
    			title: 'Register'
    		});
    	}, 200);
    })
    .extractExtraRegistrationParams( function (req) {
    	return {
    		email: req.body.email
    	};
    })
    .validateRegistration( function (newUserAttrs, errors) {
    	var login = newUserAttrs.login;
    	if (usersByLogin[login]) errors.push('Login already taken');
    	return errors;
    })
    .registerUser( function (newUserAttrs) {
    	var login = newUserAttrs[this.loginKey()];
    	return usersByLogin[login] = newUserAttrs;
    })

    .loginSuccessRedirect('/')
    .registerSuccessRedirect('/');


    everyauth.everymodule.logoutRedirectPath('/');

    everyauth.everymodule.findUserById(function (userId, callback) {
    	db.user.findById(userId, function (err, data) {
    		callback(err, data);
    	});
    });


// App Config

app.configure('development', function(){
	app.use(express.logger('dev'));
	everyauth.debug = true;
});

app.configure(function(){
	app.set('views', __dirname + '/app/views');
	app.set('view engine', 'html');
	app.engine('html', hbs.__express);
	app.use(express.cookieParser());
	app.use(express.session({ secret: 'dsfdsf', store: new redisStore() }));
	app.use(express.bodyParser());
	app.use(everyauth.middleware(app));
	app.use(express.methodOverride());
	app.use(express['static'](__dirname + '/public'));
	app.use(flashify);
	app.use(app.router);
	app.use(function (err, req, res, next) {
		console.log(err);
		if(err == 404)
			res.render('errors/404')
		res.render('errors/500');
	})
});

app.configure('development', function(){
	app.use(express['static'](__dirname + '/public'));
	//app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
	app.use(function(err, req, res, next) {
		console.error(err);
		res.send(500, 'Sorry We\'ve had a problem')
	})
});

app.configure('production', function(){
	var oneYear = 31557600000;
	app.use(express['static'](__dirname + '/public', { maxAge: oneYear }));
	//app.use(express.errorHandler());
});

//PJAX Baby!

app.all('*', function (req, res, next) {
	if (req.headers['x-pjax'])
		res.locals.layout = 'layout-pjax.html';
	next();
});


app.get('/', function(req, res, next) {

	if(req.loggedIn){
		next();
		return true;
	}

	res.render('index');
});

// Setup Helpers required in controllers

helpers = {};

helpers._ = _;
helpers.md5 = function (string) {
	return crypto.createHash('md5').update(string).digest("hex");
};


// Register hbs/handlebars helpers & partials
hbs.registerHelper('user_preferred_name', function(userProfile) {
	if(typeof userProfile.realName !== "undefined")
		return userProfile.realName;
	return userProfile.username;
});

hbs.registerHelper('gravatar_url', function(gravatarHash, size) {
	if(gravatarHash.match(/@/))
		gravatarHash = helpers.md5(gravatarHash);
	return "http://www.gravatar.com/avatar/" + gravatarHash + "?s=" + size || 140;
});

hbs.registerHelper('time_ago', function(date, size) {

	// Inspired by https://github.com/elving/swag/blob/00b3213de4811c0f27cb46c89b8ddae6b2e15702/src/swag.dates.coffee#L94

	date = new Date(date)
	seconds = Math.floor((new Date() - date) / 1000)

	interval = Math.floor(seconds / 31536000)
	if (interval > 1)
		return interval + " years ago"

	interval = Math.floor(seconds / 2592000)
	if (interval > 1)
		return interval + " months ago"

	interval = Math.floor(seconds / 86400)
	if (interval > 1)
		return interval + " days ago"

	interval = Math.floor(seconds / 3600)
	if (interval > 1)
		return interval + " hours ago"

	interval = Math.floor(seconds / 60)
	if (interval > 1)
		return interval + " minutes ago"

	if (Math.floor(seconds) == 0)
		return 'Just now'
	else
		return Math.floor(seconds) + ' seconds ago';

});

hbs.registerHelper('project_widget', function(project) {

	projectImage = '/assets/img/DefaultProjectWidget.png';
	return [' <div class="projectwidget" onclick="location.href=\'/project/' + project.name + '\';" style="background-image:url(\'' + projectImage + '\');">',
				'<div class="info">',
				'	<h3>' + project.name + '</h3><p>Created By: <a href="user/' + project.creator.username + '">' + project.creator.username + '</a>.</p>',
				'</div>',
			'</div>'].join('');

});

app.get('/500', function(req, res, next) {
	next('Test Error');
});

app.get('/404', function(req, res, next) {
	next(404);
});


require('./app/controllers');



app.listen(process.env.PORT || 3000);