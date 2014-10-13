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
