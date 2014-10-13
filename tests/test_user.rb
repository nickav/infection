require 'test/unit'
require './user.rb'
require './infection.rb'
require 'pry'

class TestUser < Test::Unit::TestCase

  def test_add_student
    t = User.new
    u = User.new
    t.add_student u

    assert_equal t.coaches.first, u
    assert_equal t.coaches.length, 1
    assert_equal u.is_coached_by.first, t
    assert_equal u.is_coached_by.length, 1
  end
end
