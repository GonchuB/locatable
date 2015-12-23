class Table < ActiveRecord::Base
  has_many :reservation_table_audits

  STATUSES = %w[free asked_for_check assigned]
  STATUS_FREE, STATUS_ASKED_FOR_CHECK, STATUS_ASSIGNED = STATUSES

  scope :free, -> { where(status: STATUS_FREE) }
  scope :asked_for_check, -> { where(status: STATUS_ASKED_FOR_CHECK) }
  scope :assigned, -> { where(status: STATUS_ASSIGNED) }

  validates :status, inclusion: STATUSES

  def self.unique_capacities
    pluck(:capacity).uniq
  end

  def change_status(new_status)
    TableStatusChangeService.new(self).call(new_status)
  end

  def average_stay_time
    if self.average_stay_time_updated_at.blank? || self.average_stay_time_updated_at < 1.hour.ago
      binding.pry
      average_time = AverageStayTimeService.new(self).call / 1.minute
      self.update_attributes(average_stay_time_cache: average_time, average_stay_time_updated_at: Time.current)
    end

    self.average_stay_time_cache
  end

  def remaining_time
    @remaining_time ||= RemainingTimeService.new(self).call / 1.minute
  end
end
