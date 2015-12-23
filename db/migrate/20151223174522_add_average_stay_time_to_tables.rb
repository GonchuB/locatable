class AddAverageStayTimeToTables < ActiveRecord::Migration
  def change
    add_column :tables, :average_stay_time_cache, :integer
    add_column :tables, :average_stay_time_updated_at, :datetime
  end
end
