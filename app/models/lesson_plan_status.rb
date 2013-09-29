class LessonPlanStatus < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  has_many :lesson_plans
end
