require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative("../member")

class TestMember < MiniTest::Test

  def setup
    options = {
      'first_name' => 'Robin',
      'last_name' => 'Gribbles',
      'date_of_birth' => '1991-06-01',
      'membership_type' => 'peak',
      'membership_status' => 'Active'
      }
    @members = Member.new(options)
  end

  def test_first_name()
    result = @members.first_name()
    assert_equal('Robin', result)
  end

  def test_last_name()
    result = @members.last_name()
    assert_equal('Gribbles', result)
  end

  def test_date_of_birth()
    result = @members.date_of_birth()
    assert_equal('1991-06-01', result)
  end

  def test_membership_type()
    result = @members.membership_type()
    assert_equal('peak', result)
  end

  def test_format_name()
    result = @members.format_name()
    assert_equal('Robin Gribbles', result)
  end

  def test_membership_status()
    result = @members.membership_status()
    assert_equal('Active', result)
  end
end
