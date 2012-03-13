#!/usr/bin/env ruby

require 'sequel'
require 'eventmachine'

module Http
  def receive_data(data)
    config = {:host => ENV['BENCHMARK_HOST'], :user => ENV['BENCHMARK_USER'], :password => ENV['BENCHMARK_PASS'],
              :port => ENV['BENCHMARK_PORT'], :sock => nil, :adapter => 'mysql', :database => ENV['BENCHMARK_DB']}
    @dba = Sequel.connect config
    @dba["SELECT name, email_address FROM user, profile WHERE profile.id = user.profile_id"].all
    send_data data.to_s
    close_connection_after_writing
  end
end

EventMachine::run do
  EventMachine::start_server "0.0.0.0", 8000, Http
  puts "listening"
end
