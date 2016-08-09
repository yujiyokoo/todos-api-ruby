require './todo_repo'
require 'grape'

module Todos
  class API < Grape::API
    version 'v1'
    format :json
    prefix :api

    resource :todos do
      desc 'Index todos'
      get '/' do
        TodoRepo.new(TodoRepo.rom).query(nil)
      end

      post '/' do
        todo = TodoRepo.new(TodoRepo.rom).create(
          description: params[:description],
          completed:   params[:completed]
        )

        if todo.id
          header 'Location', "/api/v1/todos/#{todo.id}"
        end
      end

      patch '/:id' do
        update_hash = {}
        update_hash = update_hash.merge(description: params[:description]) if params[:description]
        update_hash = update_hash.merge(completed: params[:completed]) unless params[:completed].nil?
        todo = TodoRepo.new(TodoRepo.rom).update(
          params[:id],
          update_hash
        )
      end
    end
  end
end
