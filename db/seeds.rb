require_relative('../models/groupexercise')
require_relative('../models/member')
require_relative('../models/booking')
require_relative('../models/instructor')
require_relative('../models/profile')
require_relative('../models/schedule')


GroupExercise.delete_all()
Member.delete_all()
Booking.delete_all()
Instructor.delete_all()
Schedule.delete_all()

d = Date.today.to_s
d1 = Date.today + 1

instructor1 = Instructor.new({
  'first_name' => 'Elaine',
  'last_name' => 'Kong',
  'speciality' => 'Legs'
  })
instructor1.save

instructor2 = Instructor.new({
  'first_name' => 'Daryl',
  'last_name' => 'Nichole',
  'speciality' => 'Weight Lifting'
  })
instructor2.save

group1 = GroupExercise.new({
  'name' => 'Pilates',
  'set_date' => d1.to_s,
  'start_time' => '13:00:00',
  'price' => 5.00,
  'capacity' => 10,
  'instructor_id' => instructor1.id})
group1.save

group2 = GroupExercise.new({
  'name' => 'Strength',
  'set_date' => d,
  'start_time' => '19:00:00',
  'price' => 7.00,
  'capacity' => 7,
  'instructor_id' => instructor2.id})
group2.save

group3 = GroupExercise.new({
  'name' => 'Cycling',
  'set_date' => d,
  'start_time' => '14:00:00',
  'price' => 3.00,
  'capacity' => 6,
  'instructor_id' => instructor1.id})
group3.save

group4 = GroupExercise.new({
  'name' => "Yoga",
  'set_date' => d1.to_s,
  'start_time' => '10:00:00',
  'price' => 1.00,
  'capacity' => 4,
  'instructor_id' => instructor1.id})
group4.save

member1 = Member.new({
  'first_name' => 'Robin',
  'last_name' => 'Gribbles',
  'date_of_birth' => '1991-06-01',
  'membership_type' => 'Peak',
  'membership_status' => 'Active'})
member1.save

member2 = Member.new({
  'first_name' => 'Sunny',
  'last_name' => 'Suen',
  'date_of_birth' => '1999-04-10',
  'membership_type' => 'Peak',
  'membership_status' => 'Active'})
member2.save

member3 = Member.new({
  'first_name' => 'Joe',
  'last_name' => 'Mcdonald',
  'date_of_birth' => '1996-08-01',
  'membership_type' => 'Peak',
  'membership_status' => 'Active'})
member3.save

member4 = Member.new({
  'first_name' => 'Leonardo',
  'last_name' => 'Raphael',
  'date_of_birth' => '1980-12-19',
  'membership_type' => 'Off-Peak',
  'membership_status' => 'Active'})
member4.save

member5 = Member.new({
  'first_name' => 'Hugie',
  'last_name' => 'Ward',
  'date_of_birth' => '1978-09-22',
  'membership_type' => 'Off-Peak',
  'membership_status' => 'Active'})
member5.save

member6 = Member.new({
  'first_name' => 'Joe',
  'last_name' => 'Blogs',
  'date_of_birth' => '1962-01-22',
  'membership_type' => 'Off-Peak',
  'membership_status' => 'Active'})
member6.save

member7 = Member.new({
  'first_name' => 'Adrian',
  'last_name' => 'High',
  'date_of_birth' => '2001-04-11',
  'membership_type' => 'Off-Peak',
  'membership_status' => 'Deactivated'})
member7.save

member8 = Member.new({
  'first_name' => 'Juliea',
  'last_name' => 'Roberts',
  'date_of_birth' => '1943-07-28',
  'membership_type' => 'Off-Peak',
  'membership_status' => 'Active'})
member8.save

member9 = Member.new({
  'first_name' => 'Jack',
  'last_name' => 'Sparrow',
  'date_of_birth' => '2001-10-08',
  'membership_type' => 'Peak',
  'membership_status' => 'Active'})
member9.save

member10 = Member.new({
  'first_name' => 'Jessie',
  'last_name' => 'James',
  'date_of_birth' => '1993-10-07',
  'membership_type' => 'Peak',
  'membership_status' => 'Active'})
member10.save

profile1 = Profile.new({
  'member_id' => member1.id,
  'photo_url' => 'Robin Gribbles.jpg'
  })
profile1.save
profile2 = Profile.new({
  'member_id' => member2.id,
  'photo_url' => 'Sunny Suen.jpg'
  })
profile2.save

booking1 = Booking.new({
  'member_id' => member1.id,
  'groupexercise_id' => group1.id
  })
booking1.save

booking1s = Booking.new({
  'member_id' => member1.id,
  'groupexercise_id' => group3.id
  })
booking1s.save

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
  'groupexercise_id' => group2.id
  })
booking4.save

booking5 = Booking.new({
  'member_id' => member5.id,
  'groupexercise_id' => group2.id
  })
booking5.save

booking6 = Booking.new({
  'member_id' => member6.id,
  'groupexercise_id' => group2.id
  })
booking6.save

booking7 = Booking.new({
  'member_id' => member7.id,
  'groupexercise_id' => group2.id
  })
booking7.save

booking8 = Booking.new({
  'member_id' => member4.id,
  'groupexercise_id' => group4.id
  })
booking8.save

booking9 = Booking.new({
  'member_id' => member5.id,
  'groupexercise_id' => group4.id
  })
booking9.save

booking10 = Booking.new({
  'member_id' => member6.id,
  'groupexercise_id' => group4.id
  })
booking10.save

booking11 = Booking.new({
  'member_id' => member8.id,
  'groupexercise_id' => group4.id
  })
booking11.save

schedule1 = Schedule.new({
  'instructor_id' => instructor1.id,
  'member_id' => member1.id,
  'meet_date' => d1.to_s,
  'meeting_time' => '13:00:00'
  })
schedule1.save

schedule2 = Schedule.new({
  'instructor_id' => instructor2.id,
  'member_id' => member2.id,
  'meet_date' => d,
  'meeting_time' => '13:00:00'
  })
schedule2.save

