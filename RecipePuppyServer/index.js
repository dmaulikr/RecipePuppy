const get = require('microrouter').get
const fetch = require('node-fetch')
const router = require('microrouter').router
const send = require('micro').send

const name = async (req, res) => {
  const recipes = []
  for (page of [1, 2]) {
    const response = await fetch(`http://www.recipepuppy.com/api/?p=${page}&q=${name}`)
    const json = await response.json()
    Array.prototype.push.apply(recipes, json.results)
  }
  send(res, 200, recipes)
}

module.exports = router(
  get('/:name', name)
)
