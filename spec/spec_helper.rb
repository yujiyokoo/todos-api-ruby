ENV['RACK_ENV'] ||= 'test'
$:.push('.')
require 'rack/test'
require 'sequel'
require 'database_cleaner'
require 'config/env'
require 'pry'

RSpec.configure do |config|
  config.before(:suite) do
    connection = Sequel.connect(ENV['DATABASE'])
    DatabaseCleaner[:sequel, { :connection => connection }]

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
