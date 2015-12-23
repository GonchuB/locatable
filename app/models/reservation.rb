class Reservation < ActiveRecord::Base
  belongs_to :table
  has_many :reservation_table_audits

  scope :without_table, -> { where(table: nil) }
  scope :past, -> { where("time <= ?", Time.current) }

  def wait_time
    if Time.current > self.time
      ((Time.current - self.time) / 1.minute).to_i
    else
      0
    end
  end

  def assign(table)
    TableAssignService.new(self).call(table)
  end

  def suggestion
    @suggestion ||= TableSuggestionService.new(self).call
  end
end
