require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative("../groupexercise")

class TestGroupExercise < MiniTest::Test

  def setup
    options = {'name' => 'pilates', 'start_time' => '13:00:00', 'price' => 5.00, 'capacity' => 10}

    @groupexercises = GroupExercise.new(options)
  end

  def test_name()
    result = @groupexercises.name()
    assert_equal('pilates', result)
  end

  def test_start_time()
    result = @groupexercises.start_time()
    assert_equal('13:00:00', result)
  end

  def test_price()
    result = @groupexercises.price()
    assert_equal(5.00, result)
  end

  def test_capacity()
    result = @groupexercises.capacity()
    assert_equal(10, result)
  end
end
