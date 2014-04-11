require 'spec_helper'

describe LessonPlanField do
  let(:account) { FactoryGirl.create :account }
  let(:user) { FactoryGirl.create :user,
    account: account }
  let(:course) { FactoryGirl.create :course, user: user }
  let(:lesson_plan) { FactoryGirl.create :lesson_plan,
    course: course, user: user }

  it "has a valid factory" do
    FactoryGirl.build(:lesson_plan_field,
      lesson_plan: lesson_plan).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:lesson_plan_field,
      lesson_plan: lesson_plan, title: nil)
      .should_not be_valid
  end

  it "is not invalid without a description" do
    FactoryGirl.build(:lesson_plan_field,
      lesson_plan: lesson_plan, description: nil)
      .should be_valid
  end
end
