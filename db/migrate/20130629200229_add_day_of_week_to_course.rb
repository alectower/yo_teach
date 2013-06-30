class AddDayOfWeekToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :day_of_week, :integer
  end
end
