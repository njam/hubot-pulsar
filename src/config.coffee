_ = require('underscore')
fs = require('fs')

class Config
  constructor: (filePath) ->
    filePath = @findConfig()
    data = @parse(filePath)
    @validate(data)
    return Object.freeze(data)

  findConfig: () ->
    if(process.env.HUBOT_PULSAR_CONFIG)
      return process.env.HUBOT_PULSAR_CONFIG
    hubotConfPath = './pulsar.config.json'
    if(fs.existsSync(hubotConfPath) && fs.statSync(hubotConfPath).isFile())
      return hubotConfPath
    return __dirname + '/../config.json'

  parse: (filePath) ->
    content = fs.readFileSync(filePath, {encoding: 'utf8'})
    return JSON.parse(content)

  validate: (data) ->
    throw new Error('Specify pulsar-rest-api url `pulsarApi.url`') unless data.pulsarApi.url

config = new Config(__dirname + '/../config.json')
module.exports = config
