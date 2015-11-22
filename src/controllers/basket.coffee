express = require 'express'
redis = require 'redis'

router = express.Router()
client = redis.createClient()

###
  Request add:

  request:
  {
    "productId" : Int
  }

  You can find the product list with 'keys product_*' in redis
  see http://redis.io/commands to know how to request it.

  response: code 200
###
router.post '/add', (req, res) -> res.sendStatus 200

###
  Request validate:  show calculate the total of the card + TVA (lets say 19.6),
  add the result in bank, and then empty basket.

  request: {}

  response: code 200
###
router.post '/validate', (req, res) -> res.sendStatus 200

###
  Request /

  request: None

  response: {
    "products": [{
        "id": Int,
        "name": String,
        "price": Int
    }]
  }
###
router.get '', (req, res) -> res.sendStatus 200

module.exports = router
