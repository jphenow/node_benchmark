http = require 'http'
fs = require 'fs'
count = 0

server = http.createServer (request, response)->
  count++
  console.log "request #{count}"
  fs.readFile './index.html', (error, content)->
    if error
      response.writeHead 500
      response.end
    else
      response.writeHead 200, 'Content-Type': 'text/html'
      response.end content, 'utf-8'
    console.log "done #{count}"
server.listen 8000
console.log 'Server running at http://0.0.0.0:8000/'
