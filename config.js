module.exports = {

	// Redis Database Connection Info
	redis: {
		host: null,
		port: null,
		auth: null
	},

	// Everyauth Additional Config
	auth: {
		github: {
			id: process.env.AUTH_GITHUB_ID || 'e2786c5a58ea63eaa507',
			secret: process.env.AUTH_GITHUB_SECRET || '00da63143f07a812b475b224623fec52865165ae'
		}
	},

	// MongoDB Configuration
	mongo: {
		uri: (process.env.MONGOLAB_URI) ? process.env.MONGOLAB_URI : null
	},

	// Force Location Configuration
	forcelocation: {
		// If not set the current domain/host should be assumed for use.
		domain: (process.env.FORCE_DOMAIN) ? process.env.FORCE_DOMAIN : null,
		// If not set the port should be assumed as 80
		port: (process.env.FORCE_PORT) ? process.env.FORCE_PORT : null,
		// If not set the protocol should be assumed as 'http://'
		protocol: (process.env.FORCE_PROTOCOL) ? process.env.FORCE_PROTOCOL : null
	},

	// ThrowAndTell
	throwandtell: {
		accessKey: process.env.THROWANDTELL_ACCESSKEY || false
	}

};