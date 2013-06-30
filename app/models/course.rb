class Course < ActiveRecord::Base
  has_many :course_calendar_days
  belongs_to :course_calendar_day
  validates :name, presence: true
end
