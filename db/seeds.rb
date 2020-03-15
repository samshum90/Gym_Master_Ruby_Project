require_relative('../models/groupexercise')
require_relative('../models/member')
require_relative('../models/booking')

require("pry-byebug")

GroupExercise.delete_all()
Member.delete_all()
Booking.delete_all()

group1 = GroupExercise.new({
  'name' => 'pilates',
  'start_time' => '13:00:00',
  'price' => 5.00,
  'capacity' => 10})
group1.save

group2 = GroupExercise.new({
  'name' => 'Strength',
  'start_time' => '14:00:00',
  'price' => 7.00,
  'capacity' => 7})
group2.save


member1 = Member.new({
  'first_name' => 'Robin',
  'last_name' => 'Gribbles',
  'date_of_birth' => '1991-06-01',
  'membership_type' => 'peak'
  })
member1.save

member2 = Member.new({
  'first_name' => 'Sunny',
  'last_name' => 'Suen',
  'date_of_birth' => '1999-04-10',
  'membership_type' => 'peak'
  })
member2.save

member3 = Member.new({
  'first_name' => 'Joe',
  'last_name' => 'Mcdonald',
  'date_of_birth' => '1996-08-01',
  'membership_type' => 'peak'
  })
member3.save

member4 = Member.new({
  'first_name' => 'Leonardo',
  'last_name' => 'Raphael',
  'date_of_birth' => '1980-12-19',
  'membership_type' => 'off-peak'
  })
member4.save

member5 = Member.new({
  'first_name' => 'Hugie',
  'last_name' => 'Ward',
  'date_of_birth' => '1978-09-22',
  'membership_type' => 'off-peak'
  })
member5.save

booking1 = Booking.new({
  'member_id' => member1.id,
  'groupexercise_id' => group1.id
  })
booking1.save

booking2 = Booking.new({
  'member_id' => member2.id,
  'groupexercise_id' => group1.id
  })
booking2.save

booking3 = Booking.new({
  'member_id' => member3.id,
  'groupexercise_id' => group1.id
  })
booking3.save

booking4 = Booking.new({
  'member_id' => member4.id,
  'groupexercise_id' => group1.id
  })
booking4.save

booking5 = Booking.new({
  'member_id' => member5.id,
  'groupexercise_id' => group2.id
  })
booking5.save


binding.pry
nil
