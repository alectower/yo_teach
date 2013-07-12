class CreateLessonPlans < ActiveRecord::Migration
  def change
    create_table :lesson_plans do |t|

      t.timestamps
    end
  end
end
