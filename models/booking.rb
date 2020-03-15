require_relative('../db/sql_runner')

class Booking

  attr_reader :id, :member_id, :groupexercise_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id'].to_i
    @groupexercise_id = options['groupexercise_id'].to_i
  end

  def save()
    sql = 'INSERT INTO bookings (
          member_id,
          groupexercise_id)
          VALUES(
          $1, $2 )
          RETURNING id'
    values = [@member_id, @groupexercise_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = 'UPDATE bookings
    SET (
    member_id,
    groupexercise_id) =
    ( $1, $2 )
    WHERE id = $3'
    values = [@member_id, @groupexercise_id, @id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [@member_id]
    results = SqlRunner.run(sql, values)
    return Member.new(results.first)
  end

  def groupexercises()
    sql = "SELECT * FROM groupexercises
    WHERE id = $1"
    values = [@groupexercise_id]
    results = SqlRunner.run(sql, values)
    return GroupExercise.new(results.first)
  end

  # def bookings
  #   sql = "SELECT m.* FROM members m
  #   INNER JOIN members b
  #   ON b.member_id = m.id
  #   INNER JOIN groupexercises b
  #   ON b.member_id = m.id
  #   WHERE b.groupexercise_id = $1;"
  #   values = [@id]
  #   results = SqlRunner.run(sql, values)
  #   return results.map { |member| Member.new(member) }
  # end
  def delete()
    sql = 'DELETE FROM bookings
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM bookings
    WHERE id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return Booking.new(results.first)
  end

  def self.delete_by_id(id)
    sql = 'DELETE FROM bookings
    WHERE id = $1'
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.all
      sql = 'SELECT * FROM bookings'
      results = SqlRunner.run(sql)
      return results.map { |booking| Booking.new( booking ) }
  end

  def self.delete_all
    sql = 'DELETE FROM bookings'
    results = SqlRunner.run(sql)
  end

end
