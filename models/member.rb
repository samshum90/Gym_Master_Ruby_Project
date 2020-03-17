require_relative('../db/sql_runner')

class Member

  attr_accessor :first_name, :last_name, :date_of_birth, :membership_type, :membership_status
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    set_date_as_array = options['date_of_birth'].split("-")
    @date_of_birth = Date.new(set_date_as_array[0].to_i,set_date_as_array[1].to_i,set_date_as_array[2].to_i)
    @membership_type  = options['membership_type']
    @membership_status = options['membership_status']
  end

  def format_name
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = 'INSERT INTO members (
          first_name,
          last_name,
          date_of_birth,
          membership_type,
          membership_status)
          VALUES(
          $1, $2, $3, $4, $5 )
          RETURNING id'
    values = [@first_name, @last_name, @date_of_birth, @membership_type, @membership_status]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = 'UPDATE members
    SET (
    first_name,
    last_name,
    date_of_birth,
    membership_type,
    membership_status
    ) =
    ( $1, $2, $3, $4, $5 )
    WHERE id = $6'
    values = [@first_name, @last_name, @date_of_birth, @membership_type, @membership_status, @id]
    SqlRunner.run(sql, values)
  end

  def groupexercise
    sql = "SELECT m.* FROM groupexercises m
    INNER JOIN bookings b
    ON b.groupexercise_id = m.id
    WHERE b.member_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |group| GroupExercise.new(group) }
  end

  def bookings()
    sql = "SELECT * FROM bookings
    WHERE member_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|booking| Booking.new(booking)}
  end

  def schedules()
    sql = "SELECT * FROM schedules
    WHERE member_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|schedules| Schedule.new(schedules)}
  end

  def instructors()
    sql = "SELECT i.* FROM instructors i
    INNER JOIN schedules s
    ON s.instructor_id = i.id
    WHERE s.member_id = $1"
    values = [@id]
    instructors = SqlRunner.run(sql, values)
    return instructors.map{|instructor|Instructor.new(instructor)}
  end

  def find_booking_id()
    sql = "SELECT * FROM bookings
    WHERE member_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    booking = Booking.new(results.first)
    return booking.id
  end

  def self.find(id)
    sql = 'SELECT * FROM members
    WHERE id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return Member.new(results.first)
  end

  def self.all
      sql = 'SELECT * FROM members'
      results = SqlRunner.run(sql)
      return results.map { |member| Member.new( member ) }
  end

  def self.delete_all
    sql = 'DELETE FROM members'
    results = SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM members
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end
end
