require_relative('../db/sql_runner')
require('date')

class Schedule

attr_reader :id
attr_accessor :meeting_time, :meet_date, :instructor_id, :member_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @instructor_id = options['instructor_id'].to_i
    @member_id = options['member_id'].to_i
    set_date_as_array = options['meet_date'].split("-")
    @meet_date = Date.new(set_date_as_array[0].to_i,set_date_as_array[1].to_i,set_date_as_array[2].to_i)
    @meeting_time = options['meeting_time']
  end

  def save()
    sql = 'INSERT INTO schedules (
          instructor_id,
          member_id,
          meet_date,
          meeting_time )
          VALUES
          ( $1, $2, $3, $4  )
          RETURNING id'
    values = [@instructor_id, @member_id, @meet_date, @meeting_time]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = 'UPDATE schedules
    SET (
      instructor_id,
      member_id,
      meet_date,
      meeting_time )
    =
    ( $1, $2, $3, $4 )
    WHERE id = $5'
    values = [@instructor_id, @member_id, @meet_date, @meeting_time, @id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [@member_id]
    results = SqlRunner.run(sql, values)
    return Member.new(results.first)
  end

  def delete()
    sql = 'DELETE FROM schedules
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def meet_time()
    sql = "SELECT * FROM schedules
    WHERE instructor_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|schedules| Schedule.new(schedules)}
  end

  def instructors()
    sql = "SELECT * FROM instructors
    WHERE id = $1"
    values = [@instructor_id]
    results = SqlRunner.run(sql, values)
    return results.map{|instructor| Instructor.new(instructor)}
  end

  def self.find(id)
    sql = 'SELECT * FROM schedules
    WHERE id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return Schedule.new(results.first)
  end

  def self.delete_by_id(id)
    sql = 'DELETE FROM schedules
    WHERE id = $1'
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.all
      sql = 'SELECT * FROM schedules'
      results = SqlRunner.run(sql)
      return results.map { |schedule| Schedule.new( schedule ) }
  end

  def self.delete_all
    sql = 'DELETE FROM schedules'
    results = SqlRunner.run(sql)
  end

end
