rval = ActiveRecord::Base.connection.tables.sort
rval.reject! do |tbl|
    ['schema_migrations','schema_info', 'sessions', 'public_exceptions'].include?(tbl)
end

rval.each do |t|
  t.classify.constantize.delete_all
end

def time
  month = Date.today.beginning_of_month
  day = month.beginning_of_week(:monday)
  hour = 8.hours.since(day.beginning_of_day)
end

def create_lesson_plans(course, *args)
  t = time
  args.each do |l|
    FactoryGirl.create :lesson_plan_with_fields,
      course: course, title: l,
      start: t, end: 1.hour.since(t)
    t += 2.days
  end
end

c = FactoryGirl.create :course, name: 'Math'
create_lesson_plans(c, "Area", "Circumference", "Pythagorean Theorem")
c = FactoryGirl.create :course, name: 'English'
create_lesson_plans(c, "Grammar", "Rhetoric", "Style of Speech")

FactoryGirl.create :to_do, body: 'Create math exam'
FactoryGirl.create :to_do, body: 'Grade english papers'
FactoryGirl.create :to_do, body: 'Fill out report cards'
FactoryGirl.create :to_do, body: 'Talk to Billy about his behavior in class'

