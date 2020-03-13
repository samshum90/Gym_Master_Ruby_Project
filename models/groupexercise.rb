require_relative('../db/sql_runner')

class GroupExercise

  attr_reader :id, :name, :start_time, :price, :capacity

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

  def self.delete_all
    sql = 'DELETE FROM groupexercises'
    results = SqlRunner.run(sql)
  end

end
