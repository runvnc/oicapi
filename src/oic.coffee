request = require 'request'
http = require 'http'

req = (type, entity, data, cb) ->
  opts =
    url: "http://#{account}.oic.io/1/#{entity}"
    headers:
      "X-OIC-API-Key": apikey
    json: data
  e, res, body = request! opts
  return new cb e, body

run = (server, domain, image, params, cb) ->
  data = {server, domain, image}
  extra = ''
  if params.environvars?
    for name, val of params.environvars
      extra += "-e #{name}=#{val}"
    delete params.environvars
  data.extraparams = extra
  for k, v of params
    data[k] = v
    
  e, res = req! 'POST', 'containers', data
  return cb e, res

exports.run = run
