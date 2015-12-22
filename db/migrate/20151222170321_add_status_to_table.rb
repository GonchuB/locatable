class AddStatusToTable < ActiveRecord::Migration
  def change
    add_column :tables, :status, :string, default: "free"
  end
end
