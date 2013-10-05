class AddLessonPlanStatusToLessonPlan < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :status, :int
  end
end
