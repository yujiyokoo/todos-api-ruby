require_relative "config/env"
require "sequel"

require "sequel/extensions/migration"

namespace :db do
  desc "Run migrations up to specified version or to latest."
  task :migrate => :database do
    migrations_directory = "db/migrate"
    db = Sequel.connect(ENV['DATABASE'])
    Sequel::Migrator.run(db, migrations_directory)

    puts "migrated database #{database_name}"
  end

  task :create do
    db = Sequel.connect(database_host + '/template1')
    db.run "CREATE DATABASE #{database_name};"
    puts "created database #{database_name}"
  end

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
