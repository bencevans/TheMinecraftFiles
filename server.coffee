
express = require 'express'

webInterface = require './app.coffee'
apiInterface = require './api/app.js'

app = express()

app.use express.vhost('api.*', apiInterface)
app.use express.vhost('*', webInterface)


app.listen process.env.PORT || 3000
