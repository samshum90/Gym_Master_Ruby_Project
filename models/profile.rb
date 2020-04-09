require_relative('../db/sql_runner')

class Profile

  attr_reader :id
  attr_accessor :photo_url, :member_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id'].to_i
    @photo_url = options['photo_url']
  end

  def save()
    sql = 'INSERT INTO profiles (
          member_id,
          photo_url)
          VALUES(
          $1, $2 )
          RETURNING id'
    values = [@member_id, @photo_url]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = 'UPDATE profiles
    SET (
    member_id,
    photo_url
    ) =
    ( $1, $2 )
    WHERE id = $3'
    values = [@member_id, @photo_url, @id]
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
    sql = 'DELETE FROM profiles
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM profiles
    WHERE id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return Profile.new(results.first)
  end

  def self.find_by_member_id(id)
    sql = 'SELECT * FROM profiles
    WHERE member_id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return Profile.new(results.first)
  end

  def self.all
      sql = 'SELECT * FROM profiles'
      results = SqlRunner.run(sql)
      return results.map { |profiles| Profile.new( profiles ) }
  end

  def self.delete_all
    sql = 'DELETE FROM profiles'
    results = SqlRunner.run(sql)
  end

end
