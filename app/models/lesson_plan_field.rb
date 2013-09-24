class LessonPlanField < ActiveRecord::Base
  belongs_to :lesson_plan
  validates_presence_of :name 
  validates_presence_of :content
end
