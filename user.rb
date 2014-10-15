#
# test class that models a database relationship of users
# users have the relations coaches and is_coached_by representing
# students in a classroom
#
# @author Nick Aversano
#

class User
  attr_accessor :coaches, :is_coached_by, :version

  def initialize
    @version = 1
    @coaches = []
    @is_coached_by = []
  end

  def add_student student
    @coaches.push student
    student.is_coached_by.push self
  end

  def add_teacher teacher
    teacher.coaches.push self
    @is_coached_by.push teacher
  end
end
