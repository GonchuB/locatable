class AverageTableTimesService
  def call
    Table.unique_capacities.each_with_object({}) do |capacity, memo|
      memo[capacity] = average_for_capacity(capacity).to_i
    end
  end

  private

  def average_for_capacity(capacity)
    tables = Table.where(capacity: capacity)

    tables.map(&:average_stay_time).sum.to_f / tables.count
  end
end
