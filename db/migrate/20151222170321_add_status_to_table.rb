class AddStatusToTable < ActiveRecord::Migration
  def change
    add_column :tables, :status, :string, default: Table::STATUS_FREE
  end
end
