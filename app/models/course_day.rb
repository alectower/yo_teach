class CourseDay < ActiveRecord::Base
  has_many :courses
  belongs_to :course
end
