require_relative "config/env"
require "sequel"

require "sequel/extensions/migration"
namespace :db do
  desc "Run migrations up to specified version or to latest."
  task :migrate, :version do |_, args|
    version = args[:version]
    migrations_directory = "db/migrate"

    db = Sequel.connect(ENV['DATABASE'])

    message = if args[:version].nil?
                Sequel::Migrator.run(db, migrations_directory)
                "Migrated to latest"
              else
                Sequel::Migrator.run(db, migrations_directory, target: version.to_i)
                "Migrated to version #{version}"
              end

    puts message
  end

  task :create do
    database_name = ENV['DATABASE'].split('/').last
    database_host = ENV['DATABASE'].split('/')[0..-2].join('/')
    db = Sequel.connect(database_host + '/template1')
    db.run "CREATE DATABASE #{database_name};"
  end
end
