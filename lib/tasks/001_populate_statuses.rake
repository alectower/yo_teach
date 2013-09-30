namespace :db do
  namespace :populate do
    desc "Populate status table with default lesson plan statuses"
    task statuses: :environment do
      LessonPlanStatus.delete_all
      LessonPlanStatus.create!(id: 1,
                               name: 'Empty',
                               description: 'Lesson plan contains details but no content.')
      LessonPlanStatus.create!(id: 2,
                               name: 'Partial',
                               description: 'Lesson plan contains details and partial content, but has some empty fields.')
      LessonPlanStatus.create!(id: 3,
                               name: 'Complete',
                               description: 'Lesson plan contains details and content in all fields.')
      LessonPlanStatus.create!(id: 4,
                               name: 'None',
                               description: 'Not keeping track, I don\'t care about status.')
    end
  end
end
