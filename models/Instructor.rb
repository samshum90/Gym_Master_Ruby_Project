require_relative('../db/sql_runner')

class Instructor

  attr_reader :id
  attr_accessor :first_name, :last_name, :speciality

  require_relative('../db/sql_runner')

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @speciality = options['speciality']
  end

    def format_name
      return "#{@first_name} #{@last_name}"
    end

    def save()
      sql = 'INSERT INTO instructors (
            first_name,
            last_name,
            speciality )
            VALUES(
            $1, $2, $3 )
            RETURNING id'
      values = [@first_name, @last_name, @speciality]
      results = SqlRunner.run(sql, values)
      @id = results.first()['id'].to_i
    end

    def update()
      sql = 'UPDATE instructors
      SET (
      first_name,
      last_name,
      speciality)
      =
      ( $1, $2, $3 )
      WHERE id = $4'
      values = [@first_name, @last_name, @speciality, @id]
      SqlRunner.run(sql, values)
    end

    def groupexercise
      sql = "SELECT * FROM groupexercises
      WHERE = $1;"
      values = [@groupexercise_id]
      results = SqlRunner.run(sql, values)
      return results.map { |group| GroupExercise.new(group) }
    end

    def self.find(id)
      sql = 'SELECT * FROM instructors
      WHERE id = $1'
      values = [id]
      results = SqlRunner.run(sql, values)
      return Instructor.new(results.first)
    end

    def self.all
        sql = 'SELECT * FROM instructors'
        results = SqlRunner.run(sql)
        return results.map { |instructor| Instructor.new( instructor ) }
    end

    def self.delete_all
      sql = 'DELETE FROM instructors'
      results = SqlRunner.run(sql)
    end

    def self.delete(id)
      sql = "DELETE FROM instructors
      WHERE id = $1"
      values = [id]
      SqlRunner.run( sql, values )
    end
  end
