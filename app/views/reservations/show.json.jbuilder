json.extract! @reservation, :id, :name, :diners, :time, :table, :suggestion

if @reservation.table.present?
  json.set! :table do
    json.extract! @reservation.table, :id, :code, :capacity, :status, :average_stay_time, :remaining_time
  end
end

if @reservation.suggestion.present?
  json.set! :suggestion do
    json.extract! @reservation.suggestion, :id, :code, :capacity, :status, :average_stay_time, :remaining_time
  end
end
