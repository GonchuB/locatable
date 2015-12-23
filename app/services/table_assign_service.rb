class TableAssignService < ReservationBaseService
  def call(table)
    ReservationTableAudit.find_or_create_by(reservation: reservation, table: table, to: Table::STATUS_ASSIGNED)
    table.update_attributes(status: Table::STATUS_ASSIGNED)
    reservation.update_attributes(table: table)
  end
end
