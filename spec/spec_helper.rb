require 'rack/test'
require 'sequel'
require 'database_cleaner'
require 'pry'

ENV['RACK_ENV'] ||= 'test'
require 'dotenv'

environment = ENV['RACK_ENV'] ||= 'development'
Dotenv.load(".env.#{environment}")

$:.push('.')

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
