var express = require('express'),
stylus = require('stylus'),
fs = require('fs'),
redisStore = require('connect-redis')(express),
crypto = require('crypto');
var hbs = require('hbs');

app = express();
_ = require('underscore');

//Database(s)
mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/TheMinecraftFiles', function (err) {
	if(!err)
		console.log('MongoDB Connected.');
	else
		console.warn('Unable to Connect to MongoDB');
});

Schema = mongoose.Schema;
ObjectId = Schema.ObjectId;

db = {};

_.each(fs.readdirSync('./app/models'), function (fileName, index) {
	// Retreive Schema Name (user.js => user)
	var schemaName = fileName.match(/([a-zA-Z]+)\.js/)[1];
	db[schemaName] = mongoose.model(schemaName, require('./app/models/' + fileName));
});


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
	app.set('views', __dirname + '/views');
	app.set('view engine', 'html');
	app.engine('html', hbs.__express);
	app.use(express.cookieParser());
	app.use(express.session({ secret: 'dsfdsf', store: new redisStore() }));
	app.use(express.bodyParser());
	app.use(everyauth.middleware(app));
	app.use(express.methodOverride());
	app.use(express['static'](__dirname + '/public'));
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
	app.use(express.errorHandler());
});

//PJAX Baby!

app.all('*', function (req, res, next) {
	if (req.headers['x-pjax'])
		res.locals.layout = false;
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


require('./app/controllers');



app.listen(3000);