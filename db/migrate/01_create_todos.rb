Sequel.migration do
  up do
    create_table(:todos) do
      primary_key :id
      String :description, null: false
      Boolean :completed, default: false, null: false
    end
  end

  down do
    drop_table(:artists)
  end
end
