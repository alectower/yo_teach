require 'spec_helper'

describe "LessonPlans" do

	describe "Create new lesson plan" do
		context "course exists" do 
			it "adds a new lesson plan and displays results" do
				FactoryGirl.create(:course, name: 'Math')
				visit lesson_plans_path
				page.should have_content /Lesson Plan Description/
				page.should have_content /Course/
				page.should have_content /Date/
				page.should have_content /Start Time/
				page.should have_content /End Time/
				expect {
					click_link 'New Lesson Plan'
					select 'Math', from: 'Course'
					fill_in 'Description', with: 'Mitosis'
					fill_in 'Start', with: DateTime.now
					fill_in 'End', with: 1.hour.since(DateTime.now)
					click_button 'Create Lesson Plan'
				}.to change(LessonPlan, :count).by(1)
			end
		end
	end

  describe "GET /lesson_plans/new" do
		it "provides a description field" do
			visit new_lesson_plan_path
			within "#new_lesson_plan" do
				page.should have_content "Description"
			end
		end
	end

end
