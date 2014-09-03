class AddBodyToLessonPlans < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :body, :text, default: ""
  end
end
