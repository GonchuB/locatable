1.upto(8) do |n|
  2.step(8, 2) do |capacity|
    Table.create(capacity: capacity, code: "#{n}#{capacity}".to_i)
  end
end

Table.find_each do |table|
  time = Forgery(:basic).number(at_least: 1, at_most: 10).hours.ago.at_beginning_of_hour
  name = Forgery("name").first_name + " " + Forgery("name").last_name.first + "."
  reservation = Reservation.create(diners: table.capacity, time: time, name: name)

  time_to_assign = Forgery(:basic).number(at_least: 1, at_most: 10).minutes
  Timecop.travel(time + time_to_assign) do
    reservation.assign(table)
  end

  time_for_check = Forgery(:basic).number(at_least: 30, at_most: 90).minutes
  Timecop.travel(time + time_for_check) do
    table.change_status(Table::STATUS_ASKED_FOR_CHECK)
  end

  time_to_leave = Forgery(:basic).number(at_least: 10, at_most: 30).minutes
  Timecop.travel(time + time_for_check + time_to_leave) do
    table.change_status(Table::STATUS_FREE)
  end
end

6.times do
  1.upto(3) do |n|
    time   = n.hours.since.at_beginning_of_hour
    name   = Forgery("name").first_name + " " + Forgery("name").last_name.first + "."
    diners = Forgery(:basic).number(at_least: Table.minimum(:capacity), at_most: Table.maximum(:capacity))
    Reservation.create(diners: diners, time: time, name: name)
  end
end
