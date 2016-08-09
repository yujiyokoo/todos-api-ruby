class Todo
  attr_reader :id, :description, :completed

  def initialize(attributes)
    @description, @completed = attributes.values_at(:id, :description, :completed)
  end

  def to_hash
    {
      id: @id,
      description: @description,
      completed: @completed
    }
  end
end
