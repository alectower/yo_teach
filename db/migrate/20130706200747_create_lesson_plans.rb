class CreateLessonPlans < ActiveRecord::Migration
  def change
    create_table :lesson_plans do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.references :course, index: true
      t.timestamps
    end
  end
end
