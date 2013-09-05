require 'spec_helper'

describe "LessonPlans" do

  describe "GET /lesson_plans/new" do
		it "provides a description field" do
			visit new_lesson_plan_path
			within "#new_lesson_plan" do
				page.should have_content "Description"
				page.should have_content "Add Field"
			end
		end
	end

end
