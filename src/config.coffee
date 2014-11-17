_ = require('underscore')
fs = require('fs')

class Config
  constructor: (filePath) ->
    data = @parse(filePath)
    @validate(data)
    return Object.freeze(data)

  parse: (filePath) ->
    content = fs.readFileSync(filePath, {encoding: 'utf8'})
    return JSON.parse(content)

  validate: (data) ->
    pulsarApi = data.pulsarApi
    if(!pulsarApi)
      throw new Error('Define `pulsarApi` config options')

  @findConfigPath: () ->
    if(process.env.HUBOT_PULSAR_CONFIG)
      return process.env.HUBOT_PULSAR_CONFIG
    hubotConfPath = './pulsar.config.json'
    if(fs.existsSync(hubotConfPath) && fs.statSync(hubotConfPath).isFile())
      return hubotConfPath
    return __dirname + '/../config.json'


module.exports = Config