@next_tables.each do |capacity, data|
  json.set! capacity do
    json.set! :table do
      json.extract! data[:table], :id, :code, :capacity, :status, :average_stay_time, :remaining_time
    end
    json.set! :groups_before, data[:groups_before]
  end
end
