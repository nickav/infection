require 'test/unit'
require './user.rb'
require './infection.rb'
require 'pry'

class TestInfection < Test::Unit::TestCase

  def test_total_infection
    t = User.new
    users = create_class t

    # test teachers infecting students
    total_infection t, 2
    assert_true check_version users, 2

    # test students infecting teachers
    total_infection t.coaches.last, 3
    assert_true check_version users, 3
  end

  def test_limited_infection_limit
    t = User.new
    users = create_class t

    limited_infection t, 2, 10
    assert_false check_version users, 2

    limited_infection t, 3, 11
    assert_true check_version users, 3
  end

=begin
  def test_limited_infection_2
    t = User.new
    users = create_class t

    limited_infection t.coaches.first, 2, 8
  end
=end

  # helper functions
  def create_class t, size = 10
    users = []
    users << t
    size.times do
      u = User.new
      t.add_student u 
      users << u
    end
    return users
  end

  def check_version users, version
    good = true
    for u in users
      if u.version != version
        good = false
        break
      end
    end

    return good
  end
end
