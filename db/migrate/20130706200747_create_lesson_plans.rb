class CreateLessonPlans < ActiveRecord::Migration
  def change
    create_table :lesson_plans do |t|
      t.string :objectives
      t.string :lesson_steps
      t.date :date
      t.references :course, index: true
      t.timestamps
    end
  end
end
