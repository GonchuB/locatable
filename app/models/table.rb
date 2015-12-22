class Table < ActiveRecord::Base
  has_many :reservation_table_audits

  STATUSES = %w[free asked_for_check assigned]

  validates :status, inclusion: STATUSES

  def change_status(new_status)
    last_audit = self.reservation_table_audits.last
    return if last_audit.to == new_status

    self.reservation_table_audits.create(reservation: last_audit.reservation, from: last_audit.to, to: new_status)
    self.update_attributes(status: new_status)
  end

  def average_stay_time
    return @average_stay_time if @average_stay_time.present?

    return 60 if reservation_table_audits.empty?

    table_audits = reservation_table_audits
    if table_audits.last.to != "free"
      reservation_id = reservation_table_audits.last.reservation_id
      table_audits = reservation_table_audits.where.not(reservation_id: reservation_id)
    end

    reservation_ids = table_audits.pluck(:reservation_id).uniq
    return 60 if reservation_ids.empty?

    seconds = reservation_ids.inject(0) do |memo, reservation_id|
      audits = reservation_table_audits.where(reservation_id: reservation_id)
      memo + (audits.last.created_at - audits.first.created_at)
    end

    @average_stay_time ||= to_minutes(seconds / reservation_ids.count)
  end

  def remaining_time
    return @remaining_time if @remaining_time.present?
    return 0 if self.status == "free"
    return 60 if reservation_table_audits.empty?

    seconds = Time.current - reservation_table_audits.first.created_at
    @remaining_time ||= average_stay_time - to_minutes(seconds)
  end

  private

  def to_minutes(seconds)
    (seconds / 60).to_i
  end
end
