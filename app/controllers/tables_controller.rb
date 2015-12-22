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
    @next_tables = NextTablesService.new.call
  end

  private

  def set_table
    @table = Table.find(params[:id])
  end
end
