#!/usr/bin/env ruby

require 'eventmachine'

module Http
  def receive_data(data)
    send_data "Hello World"
    close_connection_after_writing
  end
end

EventMachine::run do
  EventMachine::start_server "0.0.0.0", 8000, Http
  puts "listening"
end
