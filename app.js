var express = require('express'),
stylus = require('stylus'),
fs = require('fs'),
redisStore = require('connect-redis')(express),
crypto = require('crypto'),
http = require('http');

app = express();
var server = http.createServer(app);

var flashify = require('flashify');
_ = require('underscore');
hbs = require('hbs');
config = {mongo:{}};

// Bootstrap (DB Etc.)
require('./bootstrap.js');

// TMF Library
tmflib = require('./lib/tmf.js');
tmf= tmflib.createInterface(db);


// Authentication Requirements
everyauth = require('everyauth');

_.each(fs.readdirSync('./app/auth'), function(authModule) {
	require('./app/auth/' + authModule);
})

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
			res.render('errors/404');
		res.render('errors/500');
	});
});

app.configure('development', function(){
	app.use(express['static'](__dirname + '/public'));
	// app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
	app.use(function(err, req, res, next) {
		console.error(err);
		res.send(500, 'Sorry We\'ve had a problem');
	});
});

app.configure('production', function(){
	var oneYear = 31557600000;
	app.use(express['static'](__dirname + '/public', { maxAge: oneYear }));
	// app.use(express.errorHandler());
});

// PJAX

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

_.each(fs.readdirSync('./app/view_helpers'), function(view_helper) {
	require('./app/view_helpers/' + view_helper);
})

app.get('/500', function(req, res, next) {
	next('Test Error');
});

app.get('/404', function(req, res, next) {
	next(404);
});

app.get('/worker', function(req, res, next) {
	var cluster = require('cluster');
	res.send(200, cluster.worker.process.pid + ' ' + cluster.worker.id);
})


require('./app/controllers');




server.listen(process.env.PORT || 3000);