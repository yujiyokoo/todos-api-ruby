require 'dotenv'
Dotenv.load

require './todos_api'
run TodosAPI.freeze.app
