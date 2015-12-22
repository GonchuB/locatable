class TablesController < ApplicationController
  before_action :set_table, only: [:show, :change_status]

  def index
    @tables = Table.all
  end

  def show
  end

  def change_status
    @table.change_status(params[:status])
    render :show
  end

  def next_tables
    @next_tables = Table.pluck(:capacity).uniq.each_with_object({}) do |capacity, memo|
      memo[capacity] = {}
      memo[capacity][:table] = next_table(capacity)
      memo[capacity][:groups_before] = Reservation.where(table: nil, diners: capacity).where("time <= ?", Time.current).count
    end
  end

  private

  def set_table
    @table = Table.find(params[:id])
  end

  def next_table(capacity)
    tables = Table.where(capacity: capacity)

    if table = tables.find_by(status: "free")
      table
    else
      tables.sort { |a, b| a.remaining_time <=> b.remaining_time }.first
    end
  end
end
