class AddStartIndexToLessonPlans < ActiveRecord::Migration
  def change
    add_index :lesson_plans, :start
  end
end
