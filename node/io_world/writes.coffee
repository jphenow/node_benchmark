http = require 'http'
fs = require 'fs'
mysql = require 'mysql'

server = http.createServer (request, response)->
  query_db (content)->
      response.writeHead 200, 'Content-Type': 'text/html'
      response.end content, 'utf-8'

server.listen 8000
console.log 'Server running at http://0.0.0.0:8000/'
host = String(process.env.BENCHMARK_HOST)
user = String(process.env.BENCHMARK_USER)
pass = String(process.env.BENCHMARK_PASS)
db = String(process.env.BENCHMARK_DB)

query_db = (callback)->
  client = mysql.createClient
    user: user
    password: pass
    host: host

  client.query "USE #{db}", (err)->
    insert_times client, callback, 20

insert_times = (client, callback, iteration)->
  if iteration >= 1
    client.query "INSERT INTO user (name, profile_id) VALUES ('Node', 2)",
      (err)->
        iteration = iteration - 1
        insert_times(client, callback, iteration)
  else
    client.end()
    callback("Insert complete")
