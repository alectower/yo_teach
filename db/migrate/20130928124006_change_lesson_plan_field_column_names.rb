class ChangeLessonPlanFieldColumnNames < ActiveRecord::Migration
  def change
    change_table :lesson_plan_fields do |t|
    t.rename :name, :title
    t.rename :content, :description
    end
  end
end
