require 'spec_helper'

describe LessonPlan do
  let(:user) { FactoryGirl.create :user }

  it "has a valid factory" do
    FactoryGirl.create(:lesson_plan, user: user).
      should be_valid
  end

  it 'is invalid without a user' do
    FactoryGirl.build(:lesson_plan, user: nil).
      should_not be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:lesson_plan, user: user,
      title: nil).should_not be_valid
  end

  it "is invalid without a course" do
    FactoryGirl.build(:lesson_plan, user: user,
      course: nil).should_not be_valid
  end

  it "is invalid without a start date" do
    FactoryGirl.build(:lesson_plan, user: user,
      start: nil).should_not be_valid
  end

  it "is invalid without an end date" do
    FactoryGirl.build(:lesson_plan, user: user,
      end: nil).should_not be_valid
  end

  context "created with empty field descriptions" do
    it "is created with an empty status" do
      FactoryGirl.create(:lesson_plan, user: user).
        complete.should eq false
    end
  end
end
