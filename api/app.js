
var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path');

var app = express();

app.configure(function(){
  app.use(function (req, res, next) {
    res.removeHeader("X-Powered-By");
    next();
  });
  app.set('port', process.env.PORT || 3000);
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  // Limiter & Authentication Checker
  app.use(function(err, req, res, next) {
    // Check Key is provided
    if(typeof req.query.access_token == 'undefined') {
      res.status(401);
      return res.send({message:'No Access Token Provided'});
    }
    // Check valid key exists
    db.api.findOne({token:req.query.access_token}, function (err, key) {
      if(err) return next(err);
      if(!key) {
        res.status(401);
        res.send({message:'Incorrect Access Token'});
      }
    });
    // Add rate limit

  });
  app.use(express.methodOverride());
  app.use(app.router);
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

app.get('/project/:project', routes.project);
app.get('/user/:user', routes.user);
app.get('/user/:user/projects', routes.user.projects);

app.get('*', function (req, res, next) {
  // If Browser, redirect to User Interface
  if(req.accepts('html')) return res.redirect('http://theminecraftfiles.com');
  // Else JSON Not Found
  res.status(404);
  res.send({message: 'Not Found'});
});

module.exports = app;