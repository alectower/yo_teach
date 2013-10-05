module LessonPlanHelper

  def status_class(lesson_plan = @lesson_plan)
    case lesson_plan.status
    when LessonPlan::EMPTY
      'badge badge-important'
    when LessonPlan::IN_PROGRESS
      'badge badge-warning'
    when LessonPlan::COMPLETE
      'badge badge-success'
    end
  end

end
