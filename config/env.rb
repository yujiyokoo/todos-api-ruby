require 'dotenv'
environment = ENV['RACK_ENV'] ||= 'development'
Dotenv.load(".env.#{environment}")
