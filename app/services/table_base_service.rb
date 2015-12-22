class TableBaseService
  attr_accessor :table, :audits

  def initialize(table)
    @table  = table
    @audits = table.reservation_table_audits || ReservationTableAudit.none
  end
end
