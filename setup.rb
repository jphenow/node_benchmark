#!/usr/bin/env ruby

can_continue = true

check_existence = {"node" => "Please install Node.js, you can find instructions here https://gist.github.com/579814",
                  "npm" => "Please install npm, you can find instructions here https://gist.github.com/579814",
                  "php" => "Please install PHP, consult instructions per your operating system",
                  "mysql" => "Please install MySQL, consult instructions per your operating system"}

puts "Checking that you have necessary tools"

check_existence.each_pair do |item, explanation|
  cmd = "which #{item} > /dev/null"
  status = system(cmd)
  unless status != 0
    can_continue = false
    puts explanation
  end
end

if can_continue
  system "cd db/; bundle install; ./db_filler.rb; cd ../"
  exit_status = system("echo $? > /dev/null")
  if exit_status
    system "touch .can_run"
    puts "Ready for testing, captain!"
  else
    puts "There was an issue setting up your environment"
  end
end
