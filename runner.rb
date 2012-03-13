#!/usr/bin/env ruby

10.times do |iter|
  `echo "BEGIN ##{iter}" >> runner.out`
  `ab -n500 -c10 http://127.0.0.1:8000/ >> runner.out`
  `echo "END ##{iter}" >> runner.out`
end

out = File.open "runner.out"
final_out = ""
iter = 0
out.each_line do |line|
  answer = ""
  if line.include? "Time taken for tests"
    answer = line.split(" ").select{|x|x.match(/\d/)}.first
    final_out << "Run ##{iter}: #{answer}"
    final_out << "\n"
    iter += 1
  end
end

puts final_out
