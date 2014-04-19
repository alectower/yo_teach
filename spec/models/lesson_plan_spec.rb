require 'spec_helper'

describe LessonPlan do
  let(:user) { FactoryGirl.create :user }
  let(:course) { FactoryGirl.create :course, user: user }

  it "has a valid factory" do
    FactoryGirl.create(:lesson_plan, course: course,
      user: user).should be_valid
  end

  it 'is invalid without a user' do
    FactoryGirl.build(:lesson_plan, user: nil,
      course: course).should_not be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:lesson_plan, user: user,
      course: course, title: nil).should_not be_valid
  end

  it "is invalid without a course" do
    FactoryGirl.build(:lesson_plan, user: user,
      course: nil).should_not be_valid
  end

  it "is invalid without a start date" do
    FactoryGirl.build(:lesson_plan, user: user,
      course: course, start: nil).should_not be_valid
  end

  it "is invalid without an end date" do
    FactoryGirl.build(:lesson_plan, user: user,
    course: course, end: nil).should_not be_valid
  end

  context "created with empty field descriptions" do
    it "is created with an empty status" do
      FactoryGirl.create(:lesson_plan, user: user,
        course: course).status.should eq LessonPlan::EMPTY
    end
  end

  context "created with some field descriptions" do
    it "is created with an in progress status" do
      l = FactoryGirl.build(:lesson_plan, course: course,
        user: user)
      l.fields.build title: 'Homework',
        description: 'Read'
      l.fields.build title: 'Activities', description: nil
      l.save
      l.status.should eq LessonPlan::IN_PROGRESS
    end
  end

  context "created with non-empty field descriptions" do
    it "is created with an complete status" do
      l = FactoryGirl.build(:lesson_plan, course: course,
        user: user)
      l.fields.build title: 'Homework',
        description: 'Read'
      l.fields.build title: 'Activities', description: 'Discuss Reading'
      l.save
      l.status.should eq LessonPlan::COMPLETE
    end
  end
end
