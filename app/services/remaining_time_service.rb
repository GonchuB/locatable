class RemainingTimeService < TableBaseService
  DEFAULT_REMAINING_TIME = 3600

  def call
    return 0 if table.status == Table::STATUS_FREE
    return DEFAULT_REMAINING_TIME if audits.empty?

    elapsed_time   = Time.current - audits.where(to: Table::STATUS_ASSIGNED).last.created_at
    remaining_time = (table.average_stay_time * 1.minute) - elapsed_time

    if remaining_time > 0
      remaining_time.to_i
    else
      0
    end
  end
end
