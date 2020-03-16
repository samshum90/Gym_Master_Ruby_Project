require_relative('../db/sql_runner')
require('pry')
require('date')

class GroupExercise

  attr_accessor :name, :set_date, :start_time, :price, :capacity
  attr_reader :id, :instructor_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    set_date_as_array = options['set_date'].split("-")
    @set_date = Date.new(set_date_as_array[0].to_i,set_date_as_array[1].to_i,set_date_as_array[2].to_i)
    @start_time = options['start_time']
    @price = options['price']
    @capacity = options['capacity'].to_i
    @instructor_id = options['instructor_id'].to_i
  end

  def membership_needed_check()
    if @start_time >= '06:00:00' && @start_time <= '16:00:00'
      return 'Peak'
    else
      return 'Off-Peak'
    end
  end

  def save()
    sql = 'INSERT INTO groupexercises (
          name,
          set_date,
          start_time,
          price,
          capacity,
          instructor_id)
          VALUES(
          $1, $2, $3, $4, $5, $6 )
          RETURNING id'
    values = [@name, @set_date, @start_time, @price, @capacity, @instructor_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = 'UPDATE groupexercises
    SET (
    name,
    set_date,
    start_time,
    price,
    capacity,
    instructor_id) =
    ( $1, $2, $3, $4, $5, $6 )
    WHERE id = $7'
    values = [@name, @set_date, @start_time, @price, @capacity, @instructor_id, @id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT m.* FROM members m
    INNER JOIN bookings b
    ON b.member_id = m.id
    WHERE b.groupexercise_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |member| Member.new(member) }
  end

  def booked()
    sql = "SELECT * FROM bookings
    WHERE groupexercise_id = $1"
    values = [@id]
    booked = SqlRunner.run(sql, values)
    map = booked.map{|booking| Booking.new(booking)}.size
    return map.to_i
  end

  def self.delete(id)
    sql = "DELETE FROM groupexercises
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.find(id)
    sql = 'SELECT * FROM groupexercises
    WHERE id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return GroupExercise.new(results.first)
  end

  def self.all
      sql = 'SELECT * FROM groupexercises
      ORDER BY set_date, start_time'
      results = SqlRunner.run(sql)
      return results.map { |group| GroupExercise.new( group ) }
  end

  def self.delete_all
    sql = 'DELETE FROM groupexercises'
    results = SqlRunner.run(sql)
  end

end
