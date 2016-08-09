require 'rom-repository'
require './todo'

class TodoRepo < ROM::Repository[:todos]
  commands :create, update: :by_pk

  def self.rom
    ROM.container(:sql, ENV['DATABASE'])
  end

  def query(conditions)
    #todos.where(conditions).to_a.map { |t| t.as(Todo) }
    todos.where(conditions).to_a.map { |t| t.to_hash }
  end

  def ids
    todos.pluck(:id)
  end
end
