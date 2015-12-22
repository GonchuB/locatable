class AverageStayTimeService < TableBaseService
  DEFAULT_STAY_TIME = 3600

  def call
    return DEFAULT_STAY_TIME if audits.empty?

    if audits.last.to != Table::STATUS_FREE
      reservation_id = audits.last.reservation_id
      @audits = audits.where.not(reservation_id: reservation_id)
    end

    reservation_ids = audits.pluck(:reservation_id).uniq
    return DEFAULT_STAY_TIME if reservation_ids.empty?

    reservations_duration = reservation_ids.inject(0) do |memo, reservation_id|
      @audits = audits.where(reservation_id: reservation_id)
      memo + (audits.last.created_at - audits.first.created_at)
    end

    average_stay_time = reservations_duration / reservation_ids.count

    if average_stay_time > 0
      average_stay_time.to_i
    else
      0
    end
  end
end
