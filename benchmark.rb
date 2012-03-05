#!/usr/bin/env ruby

require 'fastercsv'
require 'benchmark'
require 'curb'

base = "http://localhost"
apache = "#{base}/~jonphenow/php"
tests = ["hello","cpu","io"].collect{|s| "#{s}_world"}
times = {}

tests.each do |test|
  time = Benchmark.realtime do
    `ab -n 750 -c 750 #{apache}/#{test} > /dev/null`
  end
  times.merge!({test => time})
end

puts "Apache: "
times.each_pair do |test, time|
  puts "#{test}: #{time}"
end
