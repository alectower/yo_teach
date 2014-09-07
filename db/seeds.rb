User.delete_all
LessonPlan.delete_all
ToDo.delete_all
CoreStandard.delete_all

def time
  month = Date.today.beginning_of_month
  day = month.beginning_of_week(:monday)
  hour = 8.hours.since(day.beginning_of_day)
end

def create_lesson_plans(user, course, *args)
  t = time
  args.each_slice(3) do |week|
    week.each do |l|
      LessonPlan.create! user: user,
        course: course, title: l,
        start: t, end: 1.hour.since(t)
      t = 2.hours.since(2.days.since(t))
    end
    t = 8.hours.since 8.days.since(t).beginning_of_day
  end
end

user = User.create! name: 'Dude Man',
  email: 'user@site.com',
  password: 'password',
  password_confirmation: 'password'

create_lesson_plans(user, 'Math', 'Multiplication',
  'Division', 'Order of Operations', 'Exponents',
  'Area', 'Circumference', 'Pythagorean Theorem',
  'Distance', 'Summation')

create_lesson_plans(user, 'English',
  'Sentences', 'Paragraphs', 'Punctuation', 'Spelling',
  'Short Stories', 'Novels', 'Grammar', 'Rhetoric',
  'Style of Speech')

ToDo.create! body: 'Create math exam',
  user: user
ToDo.create! body: 'Grade english papers',
  user: user
ToDo.create! body: 'Fill out report cards',
  user: user

StandardsImport.new("db/ccssi").import
