class LessonPlanEvents

  def self.each_week(date, view)
    DateLessons.new(date)
      .range(view)
      .each_slice(7)
  end
end
