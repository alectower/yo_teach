class AddCourseToLessonPlan < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :course, :string, default: ""
    add_index :lesson_plans, :course
    remove_column :lesson_plans, :course_id, :integer
  end
end
