require 'spec_helper'

describe LessonPlan do

	it "is invalid without a description" do
		FactoryGirl.build(:lesson_plan, description: nil).
			should_not be_valid
	end

end
