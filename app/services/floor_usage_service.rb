class FloorUsageService
  def call
    floor_usage = Table.unique_capacities.each_with_object({}) do |capacity, memo|
      tables = Table.where(capacity: capacity)

      memo[capacity] = {}
      memo[capacity][:total] = tables.count
      memo[capacity][:free]  = tables.where(status: Table::STATUS_FREE).count
    end

    floor_usage[:global] = {}
    floor_usage[:global][:total] = Table.count
    floor_usage[:global][:free]  = Table.where(status: Table::STATUS_FREE).count

    floor_usage
  end

end
