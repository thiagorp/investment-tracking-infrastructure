Sequel.migration do
  change do
    create_table(:investors) do
      primary_key :id
      String :name, null: false

      DateTime :created_at
      DateTime :updated_at

      index :created_at
      index :updated_at
    end
  end
end
