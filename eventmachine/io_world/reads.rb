#!/usr/bin/env ruby

require 'sequel'
require 'eventmachine'

module Http
  def receive_data(data)
    db :cb
    close_connection_after_writing
  end

  def db(callback)
    db_defaults = {:host => "localhost", :user => "root", :password => nil,
                   :port => 3306, :sock => nil, :adapter => 'mysql', :database => 'benchmark'}
    dba = Sequel.connect db_defaults
    self.send(callback, dba["SELECT name, email_address FROM user, profile WHERE profile.id = user.profile_id"].all)
  end

  def cb(data)
    send_data data
  end
end

EventMachine::run do
  EventMachine::start_server "0.0.0.0", 8000, Http
  puts "listening"
end