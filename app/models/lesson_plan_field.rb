class LessonPlanField < ActiveRecord::Base
  belongs_to :lesson_plan
  validates_presence_of :title
  validates_presence_of :description
end
