class Course < ActiveRecord::Base
  validates_presence_of :name, :start_date,
    :end_date, :user

  belongs_to :user
  has_many :lesson_plans, dependent: :destroy

  def name_with_date
    "#{name} : #{start_date}"
  end
end
