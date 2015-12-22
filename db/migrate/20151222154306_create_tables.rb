class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :capacity
      t.integer :code

      t.timestamps null: false
    end
  end
end
