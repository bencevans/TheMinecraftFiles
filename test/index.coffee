fs = require('fs')
path = require('path')
uiTests = fs.readdirSync(path.resolve(__dirname, 'webui'))
i = uiTests.length - 1

while i >= 0
  require path.resolve(__dirname, 'webui/', uiTests[i])
  i--
