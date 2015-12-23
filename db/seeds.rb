def fake_name
  Forgery("name").first_name + " " + Forgery("name").last_name.first + "."
end

def minutes_until_assign(since)
  since + Forgery(:basic).number(at_least: 1, at_most: 10).minutes
end

def minutes_until_check(since)
  minutes_until_assign(since) + Forgery(:basic).number(at_least: 30, at_most: 90).minutes
end

def minutes_until_free(since)
  minutes_until_check(since) + Forgery(:basic).number(at_least: 10, at_most: 30).minutes
end

# Create tables with capacities in steps of two. The code has the capacity prepended.
1.upto(8) do |n|
  2.step(8, 2) do |capacity|
    Table.create(capacity: capacity, code: "#{capacity}#{n}".to_i)
  end
end

# Simulate table activity for past reservations. Simulate one run per table.
Table.find_each do |table|
  time = Forgery(:basic).number(at_least: 1, at_most: 10).hours.ago.at_beginning_of_hour
  reservation = Reservation.create(diners: table.capacity, time: time, name: fake_name)

  Timecop.travel(minutes_until_assign(time)) { reservation.assign(table) }
  Timecop.travel(minutes_until_check(time)) { table.change_status(Table::STATUS_ASKED_FOR_CHECK) }
  Timecop.travel(minutes_until_free(time)) { table.change_status(Table::STATUS_FREE) }
end

# Create pending reservations.
3.times do
  1.upto(3) do |n|
    time   = n.hours.since.at_beginning_of_hour
    diners = Forgery(:basic).number(at_least: Table.minimum(:capacity), at_most: Table.maximum(:capacity))
    Reservation.create(diners: diners, time: time, name: fake_name)
  end
end

# Assign the first half of the tables to a new reservation.
Table.first(Table.count / 2).each do |table|
  time = 1.hour.ago.beginning_of_hour
  reservation = Reservation.create(diners: table.capacity, time: time, name: fake_name)

  Timecop.travel(minutes_until_assign(time)) { reservation.assign(table) }
end

# Assign the last half of the tables to a new reservation and make them ask for the check.
Table.last(Table.count / 2).each do |table|
  time = Time.current.beginning_of_hour
  reservation = Reservation.create(diners: table.capacity, time: time, name: fake_name)

  Timecop.travel(minutes_until_assign(time)) { reservation.assign(table) }
  Timecop.travel(minutes_until_check(time)) { table.change_status(Table::STATUS_ASKED_FOR_CHECK) }
end
