require_relative('../db/sql_runner')

class Member

  attr_accessor :first_name, :last_name, :date_of_birth, :membership_type
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @date_of_birth = options['date_of_birth']
    @membership_type  = options['membership_type']
  end

  def format_name
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = 'INSERT INTO members (
          first_name,
          last_name,
          date_of_birth,
          membership_type )
          VALUES(
          $1, $2, $3, $4)
          RETURNING id'
    values = [@first_name, @last_name, @date_of_birth, @membership_type]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = 'UPDATE members
    SET (
    first_name,
    last_name,
    date_of_birth,
    membership_type ) =
    ( $1, $2, $3, $4)
    WHERE id = $5'
    values = [@first_name, @last_name, @date_of_birth, @membership_type , @id]
    SqlRunner.run(sql, values)
  end

  def groupexercise
    sql = "SELECT m.* FROM groupexercises m
    INNER JOIN bookings b
    ON b.groupexercise_id = m.id
    WHERE b.member_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |group| GroupExercise.new(group) }
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