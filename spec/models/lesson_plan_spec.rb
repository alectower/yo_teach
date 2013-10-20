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

  context "created with empty field descriptions" do
    it "is created with an empty status" do
      FactoryGirl.create(:lesson_plan).status
        .should eq LessonPlan::EMPTY
    end
  end

  context "created with some field descriptions" do
    it "is created with an in progress status" do
      l = FactoryGirl.build(:lesson_plan)
      l.fields.build title: 'Homework', description: 'Read'
      l.fields.build title: 'Activities', description: nil
      l.save
      l.status.should eq LessonPlan::IN_PROGRESS
    end
  end

  context "created with non-empty field descriptions" do
    it "is created with an complete status" do
      l = FactoryGirl.build(:lesson_plan)
      l.fields.build title: 'Homework', description: 'Read'
      l.fields.build title: 'Activities', description: 'Discuss Reading'
      l.save
      l.status.should eq LessonPlan::COMPLETE
    end
  end

  context "when searching for a lesson plan" do
    before do
      math = FactoryGirl.create(:course, name: 'Math')
      english = FactoryGirl.create(:course, name: 'English')
      @area = FactoryGirl.create(:lesson_plan, title: 'Area', course: math)
      @dare = FactoryGirl.create(:lesson_plan, title: 'Dare to be Great', course: english)
      @circumference = FactoryGirl.create(:lesson_plan, title: "Circumference", course: math)

    end
  end
end
