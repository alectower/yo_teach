class LessonPlanQuery

  def initialize(lesson_plans)
    @relation = lesson_plans
  end

  def search(args)
    by_sort(args[:sort], args[:direction])
    by_title(args[:search])
    by_course(args[:course])
    @relation
  end

  def in_range(date_range)
    @relation = @relation.where(start: date_range).
      order('start asc').group_by(&:start_date)
  end

  def by_title(title)
    @relation = @relation.where('lower(title) like ?', "%#{title}%") unless title.blank?
  end

  def by_course(course)
    @relation = @relation.where(course: course) unless course.blank?
  end

  def by_sort(column, direction)
    if !column.blank?
      if column == 'course_name'
        @relation = @relation.order("course #{sort_direction(direction)}")
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
