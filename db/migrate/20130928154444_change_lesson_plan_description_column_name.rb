class ChangeLessonPlanDescriptionColumnName < ActiveRecord::Migration
  def change
    change_table :lesson_plans do |t|
      t.rename :description, :title
    end
 end
end
