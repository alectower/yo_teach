class RemoveLessonPlanFields < ActiveRecord::Migration
  class LessonPlanField < ActiveRecord::Base
    belongs_to :lesson_plan
  end

  def up
    if table_exists? :lesson_plan_fields
      LessonPlanField.all.each do |l|
        l.lesson_plan.body = ''
        l.lesson_plan.body << l.title
        l.lesson_plan.body << '<br/><br/>'
        l.lesson_plan.body << l.description
        l.lesson_plan.save!
      end
      drop_table :lesson_plan_fields
    end
  end

  def down
    create_table :lesson_plan_fields do |t|
      t.string :name
      t.string :content
      t.references :lesson_plan, index: true

      t.timestamps
    end
  end
end
