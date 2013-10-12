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
      math = FactoryGirl.create(:lesson_plan, title: 'Area')
      english = FactoryGirl.create(:lesson_plan, title: 'Dare to be Great')
      math2 = FactoryGirl.create(:lesson_plan, title: "Circumference")
    end

    it "can be found by title" do
      results = LessonPlan.search_by_title('area')
      results.size.should eq(1)
    end

    it "can be found by partial title" do
      results = LessonPlan.search_by_title('are')
      results.size.should eq(2)
    end

    it "cannot be found with blank search terms" do
      results = LessonPlan.search_by_title('')
      results.size.should eq(3)
    end

    it "cannot be found with nil search terms" do
      results = LessonPlan.search_by_title(nil)
      results.size.should eq(3)
    end
  end
end
