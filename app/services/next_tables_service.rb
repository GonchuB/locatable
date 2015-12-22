class NextTablesService
  def call
    Table.unique_capacities.each_with_object({}) do |capacity, memo|
      memo[capacity] = {}
      memo[capacity][:table] = next_table(capacity)
      memo[capacity][:groups_before] = groups_before(capacity)
    end
  end

  private

  def next_table(capacity)
    tables = Table.where(capacity: capacity)

    if table = tables.find_by(status: Table::STATUS_FREE)
      table
    else
      tables.sort { |a, b| a.remaining_time <=> b.remaining_time }.first
    end
  end

  def groups_before(capacity)
    Reservation.past.without_table.where(diners: capacity).count
  end
end
