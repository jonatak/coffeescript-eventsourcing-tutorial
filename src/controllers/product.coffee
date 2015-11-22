express = require 'express'
redis   = require 'redis'
async   = require 'async'

router  = express.Router()
client  = redis.createClient()

router.get '', (req, res) ->

  response = {
    products : []
  }

  onComplete = (err, elems) ->
    response.products = (JSON.parse(elem) for elem in elems)
    res.setHeader 'Content-Type', 'application/json'
    res.send JSON.stringify response

  client.keys "product_*", (err, replies) ->
    repliesCallback = replies.map (reply) ->
      return (callback) ->
        client.get reply, (err, value) -> callback(err, value)
    async.parallel repliesCallback, onComplete


router.get '/:id', (req, res) ->
  client.get 'product_'+req.params.id, (err, value) ->
    if err
      res.sendStatus 404
    else
      res.setHeader 'Content-Type', 'application/json'
      res.send value


router.put '/:id', (req, res) ->
  client.set "product_"+req.params.id, JSON.stringify req.body, (err, value) ->
    redis.print err, value
    if err
      res.sendStatus 500
    else
      res.sendStatus 201

module.exports = router
