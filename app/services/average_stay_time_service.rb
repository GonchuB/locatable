class AverageStayTimeService < TableBaseService
  DEFAULT_STAY_TIME = 1.hour
  MAX_STAY_TIME = 2.5.hours

  def call
    return DEFAULT_STAY_TIME if audits.empty?

    completed_ids = complete_reservation_ids
    return DEFAULT_STAY_TIME if completed_ids.empty?

    reservations_duration = completed_ids.inject(0) do |memo, reservation_id|
      reservation_audits = audits.where(reservation_id: reservation_id)
      table_duration = reservation_audits.last.created_at - reservation_audits.first.created_at

      if table_duration > MAX_STAY_TIME
        memo + MAX_STAY_TIME
      else
        memo + table_duration
      end
    end

    average_stay_time = reservations_duration / completed_ids.count

    if average_stay_time > 0
      average_stay_time.to_i
    else
      0
    end
  end

  private

  def complete_reservation_ids
    if audits.last.to != Table::STATUS_FREE
      reservation_id = audits.last.reservation_id
      @audits = audits.where.not(reservation_id: reservation_id)
    end

    audits.pluck(:reservation_id).uniq
  end
end
