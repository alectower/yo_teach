User.delete_all
LessonPlan.delete_all
Course.delete_all
ToDo.delete_all

def time
  month = Date.today.beginning_of_month
  day = month.beginning_of_week(:monday)
  hour = 8.hours.since(day.beginning_of_day)
end

def create_lesson_plans(user, course, *args)
  t = time
  args.each_slice(3) do |week|
    week.each do |l|
      FactoryGirl.create :lesson_plan_with_fields,
        user: user,
        course: course, title: l,
        start: t, end: 1.hour.since(t)
      t = 2.hours.since(2.days.since(t))
    end
    t = 8.hours.since 8.days.since(t).beginning_of_day
  end
end

user = FactoryGirl.create :user,
  email: 'user@site.com',
  password: 'password',
  password_confirmation: 'password'

math = FactoryGirl.create :course, name: 'Math',
  user: user
create_lesson_plans(user, math, 'Multiplication', 'Division',
  'Order of Operations', 'Exponents',
  'Area', 'Circumference',
  'Pythagorean Theorem', 'Distance', 'Summation')

english = FactoryGirl.create :course, name: 'English',
  user: user
create_lesson_plans(user, english, 'Sentences', 'Paragraphs',
  'Punctuation', 'Spelling',
  'Short Stories', 'Novels',
  'Grammar', 'Rhetoric',
  'Style of Speech')

FactoryGirl.create :to_do, body: 'Create math exam',
  user: user
FactoryGirl.create :to_do, body: 'Grade english papers',
  user: user
FactoryGirl.create :to_do, body: 'Fill out report cards',
  user: user
FactoryGirl.create :to_do,
  body: 'Talk to Billy about his behavior in class',
  user: user
