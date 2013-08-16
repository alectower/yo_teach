class Course < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  has_many :lesson_plans
end
