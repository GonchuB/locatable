class Reservation < ActiveRecord::Base
  belongs_to :table
  has_many :reservation_table_audits

  scope :without_table, -> { where(table: nil) }
  scope :past, -> { where("time <= ?", Time.current) }

  def assign(table)
    TableAssignService.new(self).call(table)
  end

  def suggestion
    @suggestion ||= TableSuggestionService.new(self).call
  end
end
