class Course < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
	validates_presence_of :start_date, :end_date
  has_many :lesson_plans
end
