LessonPlan.delete_all
Course.delete_all
ToDo.delete_all

def time
  month = Date.today.beginning_of_month
  day = month.beginning_of_week(:monday)
  hour = 8.hours.since(day.beginning_of_day)
end

def create_lesson_plans(course, *args)
  t = time
  args.each_slice(3) do |week|
    week.each do |l|
      FactoryGirl.create :lesson_plan_with_fields,
        course: course, title: l,
        start: t, end: 1.hour.since(t)
      t = 2.hours.since(2.days.since(t))
    end
    t = 8.hours.since 8.days.since(t).beginning_of_day
  end
end

c = FactoryGirl.create :course, name: 'Math'
create_lesson_plans(c, 'Multiplication', 'Division',
  'Order of Operations', 'Exponents',
  'Area', 'Circumference',
  'Pythagorean Theorem', 'Distance', 'Summation')

c = FactoryGirl.create :course, name: 'English'
create_lesson_plans(c, 'Sentences', 'Paragraphs',
  'Punctuation', 'Spelling',
  'Short Stories', 'Novels',
  'Grammar', 'Rhetoric',
  'Style of Speech')

FactoryGirl.create :to_do, body: 'Create math exam'
FactoryGirl.create :to_do, body: 'Grade english papers'
FactoryGirl.create :to_do, body: 'Fill out report cards'
FactoryGirl.create :to_do, body: 'Talk to Billy about his behavior in class'
