class CreateLessonPlanFields < ActiveRecord::Migration
  def change
    create_table :lesson_plan_fields do |t|
      t.string :name
      t.string :content
      t.references :lesson_plan, index: true

      t.timestamps
    end
  end
end
