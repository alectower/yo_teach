class CreateCoreStandardsLessonPlans < ActiveRecord::Migration
  def change
    create_table :core_standards_lesson_plans, id: false do |t|
      t.integer :core_standard_id
      t.integer :lesson_plan_id
    end
  end
end
