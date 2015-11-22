express = require 'express'
bodyParser = require 'body-parser'
app = express()

app.set 'views', './views'
app.set 'view engine', 'jade'

app.use '/app', express.static __dirname + '/dist/app'
app.use '/bower_components', express.static __dirname + '/bower_components'
app.use bodyParser.json()

app.use require './dist/controllers'

app.listen 3000
console.log 'Listening on port 3000...'
