require 'spec_helper'

describe ToDo do
	it "has a valid factory" do
		FactoryGirl.build(:to_do).should be_valid
	end

	it "is invalid without a body" do
		FactoryGirl.build(:to_do, body: nil).should_not be_valid
	end
end
