class AddLessonPlanStatusToLessonPlan < ActiveRecord::Migration
  def change
    add_reference :lesson_plans,
      :lesson_plan_status, index: true
  end
end
