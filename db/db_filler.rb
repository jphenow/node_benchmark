#!/usr/bin/env ruby

module SetupDb
  class BenchmarkDb
    require 'sequel'
    require 'yaml'
    require 'pp'
    require 'faker'

    def initialize
      db_defaults = {:host => "localhost", :user => "root", :password => nil,
                    :port => 3306, :sock => nil, :adapter => 'mysql', :database => 'benchmark'}
      config = {:host => ENV['BENCHMARK_HOST'], :user => ENV['BENCHMARK_USER'], :password => ENV['BENCHMARK_PASS'],
                :port => ENV['BENCHMARK_PORT'], :sock => nil, :adapter => 'mysql', :database => ENV['BENCHMARK_DB']}
      db_connection = db_defaults.merge config
      reset_and_init_db(db_connection)
      fill_db(generate_fillers)

      @db.disconnect
    end

    def generate_fillers
      fillers = []
      1000.times do
        fillers << {:name => Faker::Name.name, :email_address => Faker::Internet.email}
      end
      fillers
    end

    def fill_db(vals)
      vals.each do |set|
        id = @db[:profile].insert :email_address => set[:email_address]
        @db[:user].insert :name => set[:name], :profile_id => id
      end
    end

    def reset_and_init_db(connection)
      @db = Sequel.connect connection

      # Need to reset connection, because above loses us selection of the
      # database
      @db.disconnect
      @db = Sequel.connect connection
      @db.create_table! :profile do
        primary_key :id
        varchar :email_address, :size => 100
      end
      @db.create_table! :user do
        primary_key :id
        varchar :name, :size => 50
        foreign_key :profile_id, :profile
      end
    end
  end
end

SetupDb::BenchmarkDb.new
