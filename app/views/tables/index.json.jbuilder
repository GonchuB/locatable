json.array!(@tables) do |table|
  json.extract! table, :id, :code, :capacity, :status
end
