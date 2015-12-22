2.step(8, 2) do |capacity|
  Table.create(capacity: capacity, code: capacity / 2)
end

1.upto(3) do |n|
  2.upto(6) do |diners|
    time = n.hours.since.at_beginning_of_hour
    name = Forgery("name").first_name + " " + Forgery("name").last_name.first + "."
    Reservation.create(diners: diners, time: time, name: name)
  end
end

Reservation.first(Table.count).each_with_index do |reservation, index|
  reservation.assign(Table.all[index])
end

Timecop.travel(35.minutes.since) do
  Table.last.change_status(Table::STATUS_ASKED_FOR_CHECK)
end

Timecop.travel(40.minutes.since) do
  Table.first.change_status(Table::STATUS_ASKED_FOR_CHECK)
end

Timecop.travel(45.minutes.since) do
  Table.first.change_status(Table::STATUS_FREE)
end
