class Reservation < ActiveRecord::Base
  belongs_to :table

  def assign(table)
    ReservationTableAudit.find_or_create_by(reservation: self, table: table, to: "assigned")
    self.update_attributes(table: table)
  end

  def suggestion
    return nil if table.present?

    self.diners.upto(self.diners + 2).each do |diners|
      tables = Table.where(capacity: diners)

      Table::STATUSES.each do |status|
        table = tables.find_by(status: status)
        return table if table.present?
      end
    end
  end
end
