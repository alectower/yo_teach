class LessonPlan < ActiveRecord::Base
  belongs_to :user

  has_and_belongs_to_many :core_standards
  accepts_nested_attributes_for :core_standards

  validates_presence_of :title, :course, :start, :end,
    :status, :user
  validates_inclusion_of :status, in: 1..3
  before_validation :update_status

  scope :in_date_range, ->(date_range) { where(start: date_range) }
  scope :by_title, ->(title) { where('lower(title) like ?', "%#{title}%") }
  scope :by_course, ->(course) { where(course: course) }
  scope :chronological, -> { order('start asc') }

  TIME_FORMAT = "%I:%M %p"

  EMPTY = 1
  IN_PROGRESS = 2
  COMPLETE = 3

  def course_name
    course
  end

  def start_date
    start.to_date
  end

  def start_time
    start.strftime(TIME_FORMAT)
  end

  def end_time
    read_attribute(:end).strftime(TIME_FORMAT)
  end

  def status_text
    case self.status
    when EMPTY
      'Empty'
    when IN_PROGRESS
      'In Progress'
    when COMPLETE
      'Complete'
    end
  end

  private

  def update_status
    self.status = body.empty? ? EMPTY : IN_PROGRESS
  end

end
