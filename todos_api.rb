require './todo_repo'
require 'multi_json'
require 'roda'

class TodosAPI < Roda
  route do |r|
    r.root do
      "hi!"
    end

    r.on 'foo' do
      r.get do
        'get foo'
      end
    end

    r.on 'api' do
      r.on 'v1' do
        r.on 'todos' do
          r.get do
            MultiJson.dump(TodoRepo.new(TodoRepo.rom).query(nil))
          end

          r.post do
            todo = TodoRepo.new(TodoRepo.rom).create(
              description: r['description'],
              completed:   r['completed']
            )

            if todo.id
              response['Location'] = "/api/v1/todos/#{todo.id}"
            end
          end

          r.put '/:id' do |id|
            update_hash = {}
            update_hash = update_hash.merge(description: r['description']) if r['description']
            update_hash = update_hash.merge(completed: r['completed']) unless r['completed'].nil?
            todo = TodoRepo.new(TodoRepo.rom).update(
              id,
              update_hash
            )
          end
        end
      end
    end
  end
end
