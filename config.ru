require 'dotenv'
Dotenv.load

require './todos_api'
run Todos::API
