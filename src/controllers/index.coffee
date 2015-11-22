express = require 'express'
redis   = require 'redis'
router  = express.Router()
client  = redis.createClient()

router.use '/basket', require './basket'
router.use '/products', require './product'

router.get '/bank', (req, res) ->
  client.get 'bank', (err, value) ->
    bank = {}
    bank.bank = value
    res.send JSON.stringify bank

router.get '/', (req, res) -> res.render('home')

router.get '/partials/:name', (req, res) ->
  name = req.params.name
  res.render 'partials/' + name

router.get '*', (req, res) -> res.render 'home'

module.exports = router
