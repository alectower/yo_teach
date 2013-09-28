require 'spec_helper'

describe LessonPlanField do
	it "has a valid factory" do
		FactoryGirl.build(:lesson_plan_field).should be_valid
	end

	it "is invalid without a title" do
		FactoryGirl.build(:lesson_plan_field, title: nil)
			.should_not be_valid
	end

	it "is not invalid without a description" do
		FactoryGirl.build(:lesson_plan_field, description: nil)
			.should be_valid
	end
end
