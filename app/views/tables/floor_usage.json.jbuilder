@usage.each do |capacity, data|
  json.set! capacity do
    json.set! :total, data[:total]
    json.set! :free,  data[:free]
  end
end
