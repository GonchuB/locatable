class TableSuggestionService < ReservationBaseService
  def call
    return nil if reservation.table.present?

    capacity_range.each do |capacity|
      tables = Table.where(capacity: capacity)

      Table::STATUSES.each do |status|
        table = tables.find_by(status: status)
        return table if table.present?
      end
    end
  end

  private

  def capacity_range
    reservation.diners.upto(reservation.diners + 2)
  end
end
