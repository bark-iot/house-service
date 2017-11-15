class CreateTableHouses < Sequel::Migration
  def up
    create_table :houses do
      primary_key :id
      column :title, String
      column :address, String
      column :key, String
      column :secret, String
      column :created_at, :timestamp
      column :updated_at, :timestamp
    end
  end

  def down
    drop_table :houses
  end
end