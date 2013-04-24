module.exports =

  # Redis Database Connection Info
  redis:
    host: null
    port: null
    auth: null


  # Everyauth Additional Config
  auth:
    github:
      id: process.env.AUTH_GITHUB_ID or "e2786c5a58ea63eaa507"
      secret: process.env.AUTH_GITHUB_SECRET or "00da63143f07a812b475b224623fec52865165ae"
      callbackURL: "http://localhost:3000/auth/github/callback"

    twitter:
      key: process.env.AUTH_TWITTER_KEY or "Yv2N4xIhID3LNhWObuccHA"
      secret: process.env.AUTH_TWITTER_SECRET or "sUtmlLjvJtCGMi026TkYG6wG45h7Uc50gAQnEnKa0I"
      callbackURL: "http://localhost:3000/auth/twitter/callback"


  # MongoDB Configuration
  mongo:
    uri: (if (process.env.MONGOLAB_URI) then process.env.MONGOLAB_URI else null)


  # Force Location Configuration
  forcelocation:

    # If not set the current domain/host should be assumed for use.
    domain: (if (process.env.FORCE_DOMAIN) then process.env.FORCE_DOMAIN else null)

    # If not set the port should be assumed as 80
    port: (if (process.env.FORCE_PORT) then process.env.FORCE_PORT else null)

    # If not set the protocol should be assumed as 'http://'
    protocol: (if (process.env.FORCE_PROTOCOL) then process.env.FORCE_PROTOCOL else null)


  # ThrowAndTell
  throwandtell:
    accessKey: process.env.THROWANDTELL_ACCESSKEY or false