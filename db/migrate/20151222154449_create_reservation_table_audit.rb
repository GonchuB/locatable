class CreateReservationTableAudit < ActiveRecord::Migration
  def change
    create_table :reservation_table_audits do |t|
      t.references :reservation, index: true, foreign_key: true
      t.references :table, index: true, foreign_key: true
      t.string :from
      t.string :to

      t.timestamps null: false
    end
  end
end
