server = require('http').createServer (request, response) ->
    response.writeHead 200, {'Content-Type': 'text/plain'}
    response.end "Number #{fib(20)}"
server.listen 8000
console.log 'Server running at http://0.0.0.0:8000/'

fib = (n) ->
  if (n < 2)
    1
  else
    fib(n-2) + fib(n-1)
