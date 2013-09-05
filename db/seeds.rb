rval = ActiveRecord::Base.connection.tables.sort
rval.reject! do |tbl|
    ['schema_migrations','schema_info', 'sessions', 'public_exceptions'].include?(tbl)
end

rval.each do |t|
	t.classify.constantize.delete_all
end

FactoryGirl.create(:course_with_lesson_plans, name: 'Math')
FactoryGirl.create(:course_with_lesson_plans, name: 'English')

4.times do
  FactoryGirl.create :to_do
end
