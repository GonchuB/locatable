class ReservationBaseService
  attr_accessor :reservation, :audits

  def initialize(reservation)
    @reservation = reservation
    @audits = reservation.reservation_table_audits || ReservationTableAudit.none
  end
end
