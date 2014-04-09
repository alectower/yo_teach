class AddUserToLessonPlans < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :user_id, :integer
    add_index :lesson_plans, :user_id
  end
end
