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
      hostname: 'localhost',
      user: 'root',
      password: '',
      database: 'benchmark'
    }).on('error', (error)->
        console.log "ERROR: #{error}"
    ).on('ready', (server)->
        console.log "Connected to #{server.hostname} (#{server.version})"
    ).connect (error)->
        if error
          return console.log('CONNECTION error: ' + error);
        for n in [0..1000]
          this.query().
            insert('user',
            ['name', 'profile_id'],
            ['Node', 2]
            ).
            execute (error, result)->
              if error
                console.log "ERROR: #{error}"
        callback(print_records("Finished Inserts!"))

print_records = (output)->
  output
