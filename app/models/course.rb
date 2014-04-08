class Course < ActiveRecord::Base
  validates :name, presence: true
  validates_presence_of :start_date, :end_date
  has_many :lesson_plans, dependent: :destroy

  def name_with_date
    "#{name} : #{start_date}"
  end
end
