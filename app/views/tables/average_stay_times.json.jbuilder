@average_times.each do |capacity, average_stay_time|
  json.set! capacity, average_stay_time
end
