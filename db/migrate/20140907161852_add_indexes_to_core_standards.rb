class AddIndexesToCoreStandards < ActiveRecord::Migration
  def change
    add_index :core_standards_lesson_plans, :core_standard_id
    add_index :core_standards_lesson_plans, :lesson_plan_id
  end
end
