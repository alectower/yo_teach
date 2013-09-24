require 'spec_helper'

describe LessonPlanField do
	it "has a valid factory" do
		FactoryGirl.build(:lesson_plan_field).should be_valid
	end

	it "is invalid without a name" do
		FactoryGirl.build(:lesson_plan_field, name: nil)
			.should_not be_valid
	end

	it "is invalid without content" do
		FactoryGirl.build(:lesson_plan_field, content: nil)
			.should_not be_valid
	end
end
