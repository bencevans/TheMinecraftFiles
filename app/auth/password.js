var usersByLogin = {
	'jim': {
		login: 'jim',
		email: 'jim@jimpick.com',
		password: 'jim'
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
	});

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