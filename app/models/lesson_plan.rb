class LessonPlan < ActiveRecord::Base
  belongs_to :course
  has_many :fields, foreign_key: 'lesson_plan_id',
    class_name: 'LessonPlanField', dependent: :destroy
  accepts_nested_attributes_for :fields,
    reject_if: :empty_attrs
  validates_presence_of :title,
                        :course,
                        :start,
                        :end,
                        :course_id,
                        :status
  validates_inclusion_of :status, in: 1..3
  before_validation :update_status

  TIME_FORMAT = "%I:%M %p"

  EMPTY = 1
  IN_PROGRESS = 2
  COMPLETE = 3

  def self.monthly_lessons(date_range)
    includes(:course)
      .where(start: date_range)
      .order('start asc')
      .group_by(&:start_date)
  end

  def self.lesson_plan_with_fields(id)
    includes(:fields, :course)
      .order("lesson_plan_fields.title asc")
      .find(id)
  end

  def self.search(args)
    return all if args.each_value.all? { |v| v.blank? }

    args.each_value do |v|
      v.downcase! unless v.blank? ||
        !v.respond_to?(:downcase?)
    end

    rel = all
    rel = by_sort(args, rel)
    rel = by_title(args, rel)
    rel = by_course(args, rel)
    rel
  end


  def self.by_title(args, rel = none)
    if !args[:search].blank?
        rel.where('lower(title) like ?', "%#{args[:search]}%")
    else
      rel
    end
  end

  def self.by_course(args, rel = none)
    if !args[:course].blank?
      rel.where(course_id: args[:course])
    else
      rel
    end
  end

  def self.by_sort(args, rel = none)
    column = args[:sort]
    if !column.blank?
      direction = args[:direction]
      if column == 'course_name'
        rel.includes(:course)
          .order("courses.name #{sort_direction(direction)}")
      else
        rel.order("#{sort_column(column)} #{sort_direction(direction)}")
      end
    else
      rel
    end
  end

  def course_name
    course.name
  end

  def start_date
    read_attribute(:start).to_date
  end

  def start_time
    read_attribute(:start).strftime(TIME_FORMAT)
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

  def empty_attrs(attrs)
    attrs[:title].blank? &&
      attrs[:description].blank?
  end

  def update_status
    self.status = IN_PROGRESS if !fields.empty? && fields.any? { |f| !f.description.blank? }
    self.status = EMPTY if fields.empty? || fields.all? { |f| f.description.blank? }
    self.status = COMPLETE if !fields.empty? && fields.all? { |f| !f.description.blank? }
  end

  def self.sort_column(col)
    LessonPlan.column_names.include?(col) ? col : 'title'
  end

  def self.sort_direction(dir)
    %w[asc desc].include?(dir) ? dir : 'asc'
  end

end
