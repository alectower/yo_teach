math = FactoryGirl.create(:course, name: 'Math')

FactoryGirl.create(:course_day, day_of_week: 2, course: math)

FactoryGirl.create(:course_day, day_of_week: 4, course: math)

FactoryGirl.create(:course_day_random, course: FactoryGirl.create(:course, name: 'English I'))

FactoryGirl.create(:course_day_random, course: FactoryGirl.create(:course, name: 'English II'))

FactoryGirl.create(:course_day_random, course: FactoryGirl.create(:course, name: 'Chemistry'))

4.times do
  FactoryGirl.create :to_do
end
