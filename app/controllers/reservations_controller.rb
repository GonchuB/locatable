class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :destroy, :assign]
  before_action :set_table, only: [:assign]

  def index
    @reservations = Reservation.where(table: nil).order(time: :asc)
  end

  def show
  end

  def destroy
    @reservation.destroy
    render :show
  end

  def assign
    @reservation.assign(@table)
    render :show
  end

  private

  def set_reservation
    @reservation ||= Reservation.find(params[:id])
  end

  def set_table
    @table ||= Table.find(params[:table_id])
  end
end
