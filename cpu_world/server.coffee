server = require('http').createServer (request, response) ->
    response.writeHead 200, {'Content-Type': 'text/plain'}
    fib 10, (n)->
      console.log "got #{n}"
      response.end "Number #{n}"
server.listen 8000
console.log 'Server running at http://0.0.0.0:8000/'

fib = (n, fn) ->
  if n < 2
    fn(n)
  else
    fib(n-1, fn) + fib(n-2, fn)
