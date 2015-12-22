class Table < ActiveRecord::Base
  has_many :reservation_table_audits

  STATUSES = %w[free asked_for_check assigned]
  STATUS_FREE, STATUS_ASKED_FOR_CHECK, STATUS_ASSIGNED = STATUSES

  validates :status, inclusion: STATUSES

  def change_status(new_status)
    TableStatusChangeService.new(self).call(new_status)
  end

  def average_stay_time
    @average_stay_time ||= AverageStayTimeService.new(self).call / 1.minute
  end

  def remaining_time
    @remaining_time ||= RemainingTimeService.new(self).call / 1.minute
  end
end
