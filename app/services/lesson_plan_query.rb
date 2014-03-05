class LessonPlanQuery

  def initialize(relation = LessonPlan.all)
    @relation = relation
  end

  def search(args)
    by_sort(args[:sort], args[:direction])
    by_title(args[:search])
    by_course(args[:course])
    @relation
  end

  def range(date_range)
    @relation = @relation.includes(:course)
      .where(start: date_range)
      .order('start asc')
      .group_by(&:start_date)
  end

  def lesson_plan_with_fields(id)
    @relation = @relation.includes(:fields, :course)
      .order("lesson_plan_fields.title asc")
      .find(id)
  end

  def by_title(title)
    @relation = @relation.where('lower(title) like ?', "%#{title}%") unless title.blank?
  end

  def by_course(course_id)
    @relation = @relation.where(course_id: course_id) unless course_id.blank?
  end

  def by_sort(column, direction)
    if !column.blank?
      if column == 'course_name'
        @relation = @relation.includes(:course)
          .order("courses.name #{sort_direction(direction)}")
      else
        @relation = @relation.order("#{sort_column(column)} #{sort_direction(direction)}")
      end
    end
  end

  def sort_column(col)
    LessonPlan.column_names.include?(col) ? col : 'title'
  end

  def sort_direction(dir)
    %w[asc desc].include?(dir) ? dir : 'asc'
  end

end
