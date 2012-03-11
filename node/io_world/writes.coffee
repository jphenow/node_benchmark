http = require 'http'
fs = require 'fs'
mysql = require 'db-mysql'

server = http.createServer (request, response)->
  query_db (content)->
      response.writeHead 200, 'Content-Type': 'text/html'
      response.end content, 'utf-8'

server.listen 8000
console.log 'Server running at http://0.0.0.0:8000/'


query_db = (callback)->
    new mysql.Database({
      hostname: process.env.BENCHMARK_HOST,
      user: process.env.BENCHMARK_USER,
      password: process.env.BENCHMARK_PASS,
      database: process.env.BENCHMARK_DB
    }).on('error', (error)->
        console.log "ERROR: #{error}"
    ).on('ready', (server)->
        console.log "Connected to #{server.hostname} (#{server.version})"
    ).connect (error)->
        if error
          return console.log('CONNECTION error: ' + error);
        for n in [0..100]
          this.query("INSERT INTO user (name, profile_id) VALUES ('Node', 2)").
          execute (error, result)->
            if error
              console.log "ERROR: #{error}"
        callback("Finished Inserts!")
