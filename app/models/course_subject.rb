class CourseSubject < ActiveRecord::Base
  belongs_to :course
  belongs_to :subject

  enum status: [:init, :start, :finish]
end
