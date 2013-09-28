require 'spec_helper'

describe LessonPlan do

	it "has a valid factory" do
		FactoryGirl.create(:lesson_plan).should be_valid
	end

	it "is invalid without a title" do
		FactoryGirl.build(:lesson_plan, title: nil)
			.should_not be_valid
	end

	it "is invalid without a course" do
		FactoryGirl.build(:lesson_plan, course: nil)
			.should_not be_valid
	end

	it "is invalid without a start date" do
		FactoryGirl.build(:lesson_plan, start: nil)
			.should_not be_valid
	end

	it "is invalid without an end date" do
		FactoryGirl.build(:lesson_plan, end: nil)
			.should_not be_valid
	end
end
