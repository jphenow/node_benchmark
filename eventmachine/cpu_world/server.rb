#!/usr/bin/env ruby

require 'eventmachine'

module Http
  def receive_data(data)
    fibonacci(20, :send_data)
    close_connection_after_writing
  end

  def fibonacci(n, callback)
    fibminus2 = 0
    fibminus1 = 1
    fib = 0

    if n == 0 or n == 1
      self.send(callback, n)
    end
    (2..n).each do
      fib = fibminus1 + fibminus2
      fibminus2 = fibminus1
      fibminus1 = fib
    end
    self.send(callback, fib)
  end
end

EventMachine::run do
  EventMachine::start_server "0.0.0.0", 8000, Http
  puts "listening"
end
