require 'spec_helper'

describe LessonPlanStatus do
  it "has a valid factory" do
    FactoryGirl.build(:lesson_plan_status).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:lesson_plan_status, name: nil).should_not be_valid
  end

  it "is invalid without a description" do
    FactoryGirl.build(:lesson_plan_status, description: nil).should_not be_valid
  end
end
