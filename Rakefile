require_relative "config/env"
require "sequel"

require "sequel/extensions/migration"

namespace :db do
  desc "Creates and migrates db"
  task :setup => :migrate do
    puts "set up #{database_name}"
  end

  desc "Run migrations up to specified version or to latest. Attempts db creation if none found."
  task :migrate => :database do
    migrations_directory = "db/migrate"
    db = Sequel.connect(ENV['DATABASE'])
    Sequel::Migrator.run(db, migrations_directory)

    puts "migrated database #{database_name}"
  end

  desc "Attempts creation of database."
  task :create do
    db = Sequel.connect(database_host + '/template1')
    db.run "CREATE DATABASE #{database_name};"
    puts "created database #{database_name}"
  end

  desc "creates database if none exists"
  task :database do
    db = Sequel.connect(ENV['DATABASE'])
    begin
      db.test_connection
    rescue Sequel::DatabaseConnectionError => ex
      if ex.message =~ /does not exist/
        Rake::Task["db:create"].invoke
      else
        raise
      end
    end
  end

  def database_name
    ENV['DATABASE'].split('/').last
  end

  def database_host
    ENV['DATABASE'].split('/')[0..-2].join('/')
  end
end
