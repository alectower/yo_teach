require 'spec_helper'

describe "LessonPlans" do

	describe "GET /lessons_plans" do
		it "displays lesson plans and their attribtues" do
			visit lesson_plans_path
			page.should have_content /Lesson Plan Description/
			page.should have_content /Course/
			page.should have_content /Date/
			page.should have_content /Start Time/
			page.should have_content /End Time/
		end
	end

	describe "POST /lesson_plans" do
		it "displays navigation links" do
			visit new_lesson_plan_path
			page.should have_content /Details/
			page.should have_content /Content/
		end

		context "course exists" do 
			it "creates a valid lesson plan" do
				FactoryGirl.create(:course, name: 'Math')
				expect {
					visit new_lesson_plan_path
					select 'Math', from: 'Course'
					fill_in 'Description', with: 'Mitosis'
					fill_in 'Start', with: DateTime.now
					fill_in 'End', with: 1.hour.since(DateTime.now)
					click_button 'Create Lesson Plan'
				}.to change(LessonPlan, :count).by(1)
			end

			context "content tab" do
				before :each do
					FactoryGirl.create :course, name: 'Math'
					visit new_lesson_plan_path
					select 'Math', from: 'Course'
					fill_in 'Description', with: 'Mitosis'
					fill_in 'Start', with: DateTime.now
					fill_in 'End', with: 1.hour.since(DateTime.now)
					click_link 'Content'
				end

				context "new custom lesson plan field" do
					it "associates field with lesson plan" do
						expect {
							page.should have_content /Add Content/
							fill_in 'Name', with: 'Homework'
							fill_in 'Content', with: 'Read ch. 1-3'
							click_button 'Create Lesson Plan'
						}.to change(LessonPlanField, :count).by(1)
						LessonPlanField.first.lesson_plan_id
							.should eq LessonPlan.first.id
					end
				end

				context "blank custom lesson plan field" do
					it "doesn't create blank lesson fields" do
						expect {
							click_button 'Create Lesson Plan'
						}.to_not change(LessonPlanField, :count)
					end
				end
			end
		end
	end

end
