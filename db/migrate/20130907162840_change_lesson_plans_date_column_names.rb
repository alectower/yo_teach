class ChangeLessonPlansDateColumnNames < ActiveRecord::Migration
  def change
  	change_table :lesson_plans do |t|
  		t.rename :start_time, :start
			t.rename :end_time, :end
		end
  end
end
