class AddCompleteToLessonPlans < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :complete, :boolean, default: false
    remove_column :lesson_plans, :status, :integer
  end
end
