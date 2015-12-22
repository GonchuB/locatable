json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :name, :diners, :time, :table
end
