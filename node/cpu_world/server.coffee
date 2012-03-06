server = require('http').createServer (request, response) ->
    response.writeHead 200, {'Content-Type': 'text/plain'}
    fibonacci 20, (x) ->
      response.end "Number #{x}"
server.listen 8000
console.log 'Server running at http://0.0.0.0:8000/'

fibonacci = (y, cb) ->
  fibminus2 = 0
  fibminus1 = 1
  fib = 0

  if y == 0 or y == 1
    cb(y)
  for num in [2..y]
    fib = fibminus1 + fibminus2
    fibminus2 = fibminus1
    fibminus1 = fib

  cb(fib)
