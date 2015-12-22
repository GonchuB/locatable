class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name
      t.integer :diners
      t.datetime :time
      t.references :table, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
