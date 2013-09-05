class CreateLessonPlans < ActiveRecord::Migration
  def change
    create_table :lesson_plans do |t|
      t.date :start_time
			t.date :end_time
      t.string :description
      t.references :course, index: true
      t.timestamps
    end
  end
end
