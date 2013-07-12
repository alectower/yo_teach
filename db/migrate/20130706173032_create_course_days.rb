class CreateCourseDays < ActiveRecord::Migration
  def change
    create_table :course_days do |t|
      t.integer :day_of_week
      t.references :course, index: true

      t.timestamps
    end
  end
end
