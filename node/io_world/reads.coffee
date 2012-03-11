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
        this.query().
            select('name, email_address').
            from(['user', 'profile']).
            where('profile.id = user.profile_id').
            execute (error, rows, cols)->
              if error
                console.log "ERROR: #{error}"
                return
              callback(print_records(rows))

print_records = (rows)->
  final = ""
  for row in rows
    final += JSON.stringify(row)
  final
