class LessonPlanField < ActiveRecord::Base
	belongs_to :lesson_plan
	validates :title, presence: true
	validates_uniqueness_of :title, scope: :lesson_plan_id
end
