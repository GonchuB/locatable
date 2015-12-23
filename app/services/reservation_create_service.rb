class ReservationCreateService
  def call(reservation_params)
    reservation_params[:time] = parse_time(reservation_params[:time])
    Reservation.create(reservation_params)
  end

  private

  def parse_time(time)
    Time.zone.parse(time)
  end
end
