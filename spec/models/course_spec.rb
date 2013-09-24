require 'spec_helper'

describe Course do
	it "has a valid factory" do
		FactoryGirl.build(:course).should be_valid
	end

	it "is invalid without a name" do
		FactoryGirl.build(:course, name: nil).should_not be_valid
	end

	it "has a unique name" do
		FactoryGirl.create(:course)
		FactoryGirl.build(:course).should_not be_valid
	end

	it "is invalid without a start date" do
		FactoryGirl.build(:course, start_date: nil).should_not be_valid
	end

	it "is invalid without an end date" do
		FactoryGirl.build(:course, end_date: nil).should_not be_valid
	end
end 
