class CreateLessonPlanStatuses < ActiveRecord::Migration
  def change
    create_table :lesson_plan_statuses do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
