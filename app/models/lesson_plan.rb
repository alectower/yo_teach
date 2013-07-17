class LessonPlan < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_day
end
