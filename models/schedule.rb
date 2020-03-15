require_relative('../db/sql_runner')

class Schedule

attr_reader :id, :instructor_id, :member_id, :groupexercise_id
attr_accessor :meeting_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @instructor_id = options['instructor_id'].to_i
    @member_id = options['member_id'].to_i
    @groupexercise_id = options['groupexercise_id'].to_i
    @meeting_time = options['meeting_time']
  end

  def save()
    sql = 'INSERT INTO schedules (
          instructor_id,
          member_id,
          groupexercise_id,
          meeting_time )
          VALUES
          ( $1, $2, $3, $4 )
          RETURNING id'
    values = [@instructor_id, @member_id, @groupexercise_id, @meeting_time]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end
  #
  # def members()
  #   sql = "SELECT * FROM members
  #   WHERE id = $1"
  #   values = [@member_id]
  #   results = SqlRunner.run(sql, values)
  #   return Member.new(results.first)
  # end
  #
  # def groupexercises()
  #   sql = "SELECT * FROM groupexercises
  #   WHERE id = $1"
  #   values = [@groupexercise_id]
  #   results = SqlRunner.run(sql, values)
  #   return GroupExercise.new(results.first)
  # end
  #
  # def delete()
  #   sql = 'DELETE FROM schedules
  #   WHERE id = $1'
  #   values = [@id]
  #   SqlRunner.run(sql, values)
  # end
  #
  # def self.find(id)
  #   sql = 'SELECT * FROM schedules
  #   WHERE id = $1'
  #   values = [id]
  #   results = SqlRunner.run(sql, values)
  #   return Schedule.new(results.first)
  # end
  #
  # def self.delete_by_id(id)
  #   sql = 'DELETE FROM schedules
  #   WHERE id = $1'
  #   values = [id]
  #   SqlRunner.run( sql, values )
  # end
  #
  # def self.all
  #     sql = 'SELECT * FROM schedules'
  #     results = SqlRunner.run(sql)
  #     return results.map { |schedule| Schedule.new( schedule ) }
  # end

  def self.delete_all
    sql = 'DELETE FROM schedules'
    results = SqlRunner.run(sql)
  end

end
