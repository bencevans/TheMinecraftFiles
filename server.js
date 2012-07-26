var express = require('express'),
app = express.createServer(),
_ = require('underscore'),
stylus = require('stylus'),
fs = require('fs'),
redisStore = require('connect-redis')(express);


//Database(s)
var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/TheMinecraftFiles', function (err) {
	if(!err)
		console.log('MongoDB Connected.');
	else
		console.warn('Unable to Connect to MongoDB');
});
var mongoSchemas = {};
var Schema = mongoose.Schema
, ObjectId = Schema.ObjectId;

mongoSchemas.user = new Schema({
	username: { type: String, required: true, lowercase: true, trim: true, index: { unique: true, sparse: true } },
	password: String,
	email: String,
	joined  :  { type: Date, default: Date.now },
	realName: String,
	minecraftUsername: String,
	website: String,
	twitterUsername: String,
	gitHubUsername: String,
	gitHubID: String
});

mongoSchemas.category = new Schema({
	name: String,
	slug: { type: String, lowercase: true, trim: true }
});

mongoSchemas.project = new Schema({
	category: ObjectId,
	created: { type: Date, default: Date.now },
	creator: ObjectId,
	image: ObjectId,
	name: String,
	slug: { type: String, required: true, lowercase: true, trim: true, index: { unique: true, sparse: true } }
});

var db = {};
_.each(mongoSchemas, function (schema, index) {
	db[index] = mongoose.model(index, schema);
})


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
	})

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
app.configure(function(){
	app.set('views', __dirname + '/views');
	app.set('view engine', 'ejs');
	app.use(express.cookieParser());
	app.use(express.session({ secret: 'dsfdsf', store: new redisStore }));
	app.use(express.bodyParser());
	app.use(everyauth.middleware());
	app.use(express.methodOverride());
	app.use(express.static(__dirname + '/public'));

	
});


app.configure('development', function(){
	everyauth.debug = true;
	app.use(express.static(__dirname + '/public'));
	app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
	var oneYear = 31557600000;
	app.use(express.static(__dirname + '/public', { maxAge: oneYear }));
	app.use(express.errorHandler());
});

//PJAX Baby!

app.all('*', function (req, res, next) {
	if (req.headers['x-pjax']) {
		app.set('view options', {
			layout: false
		});
	} else {
		app.set('view options', {
			layout: true
		});
	}
	next();
});


app.get('/', function(req, res, next) {

	if(req.loggedIn){
		next();
		return true;
	}

	res.render('index');
})

// Setup Public Routes (/routes)
var routes = {}


_.each(fs.readdirSync('./controllers'), function (fileName, index) {
	// Retreive Module Name (settings.js => settings)
	routes[fileName.match(/([a-zA-Z]+)\.js/)[1]] = require('./controllers/' + fileName)(app, db);
});

// Authenticating (Logins, Logout)
app.get('/login', function(req, res) {
	if(req.loggedIn)
		res.redirect('/')
	else
		res.render('login');
})
//Logout, handled by everyauth



// Check Authentication

app.all('*', function (req, res, next) {
	if (req.loggedIn) {
		next();
		return true;
	};
	res.render('errors/404', {
		type: 404
	});
})

// Authenticated




app.all('*', function (req, res) {
	res.render('errors/404', {
		type: 404
	});
})

everyauth.helpExpress(app);
app.listen(3000);