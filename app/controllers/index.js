app.all('*', function(req, res, next) {
	if(req.user){
		res.locals.everyauth = {user:req.user}
		res.locals.everyauth.user.loggedIn  = true;
	}
	next();
})


require('./auth');
require('./discover');
require('./user');
require('./project');


// Check Authentication
app.all('*', function (req, res, next) {
	if (req.loggedIn)
		next();
	else
		res.render('errors/404', {
			type: 404
		});
})

require('./dashboard');
require('./settings');

// 404
app.all('*', function (req, res) {
	res.render('errors/404', {
		type: 404
	});
})