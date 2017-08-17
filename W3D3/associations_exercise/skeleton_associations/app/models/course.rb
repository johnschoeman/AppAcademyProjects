class Course < ApplicationRecord
  has_many :enrollments,
    class_name: :Enrollment,
    foreign_key: :course_id,
    primary_key: :id

  has_many :enrolled_students,
    through: :enrollments,
    source: :student

  belongs_to :prerequisiste,
    class_name: :Course,
    foreign_key: :prereq_id,
    primary_key: :id


  belongs_to :instructor,
    class_name: :User,
    foreign_key: :instructor_id,
    primary_key: :id

  # has_one :prerequisite,
  #   class_name: :Prereq,
  #   foreign_key: :id,
  #   primary_key: :prereq_id

  # def prerequisite
  #   prereq = DBconnection.execute(<<-SQL, self.prereq_id)
  #     SELECT prereqs.*
  #     FROM prereqs
  #     WHERE prereqs.id = ?
  #   SQL
  #   Course.new(prereq)
  # end

  # def prerequisite
  #   prereq = DBconnection.execute(<<-SQL, self.prereq_id)
  #     SELECT course.*
  #     FROM courses
  #     WHERE course.id = ?
  #   SQL
  #   Course.new(prereq)
  # end

  # def enrollments
  #   enrollments = DBconnection.execute(<<-SQL, self.id)
  #     SELECT enrollments.*
  #     FROM enrollments
  #     WHERE enrollments.course_id = ?
  #   SQL
  # end
end
