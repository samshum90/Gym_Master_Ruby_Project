require_relative('../db/sql_runner')

class GroupExercise

  attr_accessor :name, :start_time, :price, :capacity, :booked
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @start_time = options['start_time']
    @price = options['price']
    @capacity = options['capacity']
    @booked = 0
  end

  def save()
    sql = 'INSERT INTO groupexercises (
          name,
          start_time,
          price,
          capacity)
          VALUES(
          $1, $2, $3, $4)
          RETURNING id'
    values = [@name, @start_time, @price, @capacity]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = 'UPDATE groupexercises
    SET (
    name,
    start_time,
    price,
    capacity) =
    ( $1, $2, $3, $4)
    WHERE id = $5'
    values = [@name, @start_time, @price, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def members
    sql = "SELECT m.* FROM members m
    INNER JOIN bookings b
    ON b.member_id = m.id
    WHERE b.groupexercise_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |member| Member.new(member) }
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
      sql = 'SELECT * FROM groupexercises'
      results = SqlRunner.run(sql)
      return results.map { |group| GroupExercise.new( group ) }
  end

  def self.delete_all
    sql = 'DELETE FROM groupexercises'
    results = SqlRunner.run(sql)
  end

end
