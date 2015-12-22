class Reservation < ActiveRecord::Base
  belongs_to :table

  def assign(table)
    ReservationTableAudit.find_or_create_by(reservation: self, table: table, to: "assigned")
    self.update_attributes(table: table)
  end
end
