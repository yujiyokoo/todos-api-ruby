require 'spec_helper'
require 'todos_api'

describe 'Todos' do
  include Rack::Test::Methods

  def app
    Todos::API.new
  end

  describe 'GET /' do
    it 'shows list of todos' do
      get '/api/v1/todos'
      expect(MultiJson.load(last_response.body)).to eq([])
    end
  end

  describe 'POST /' do
    it 'creates a todo' do
      expect {
        post '/api/v1/todos', description: 'newTodo', completed: false
      }.to change { TodoRepo.new(TodoRepo.rom).query(nil).to_a.size }.by(1)
    end
  end
end
