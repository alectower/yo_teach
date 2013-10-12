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
    it "can be found by title" do
      results = LessonPlan.search(search: 'area')
      results.size.should eq(1)
    end

    it "can be found by partial title" do
      results = LessonPlan.search(search: 'are')
      results.size.should eq(2)
    end

    it "cannot be found with blank search terms" do
      results = LessonPlan.search(search: '')
      results.size.should eq(3)
    end

    it "cannot be found with nil search terms" do
      results = LessonPlan.search(search: nil)
      results.size.should eq(3)
    end

    it 'can be found by course id' do
      LessonPlan.search(course: 1).size.should eq(2)
    end

    it 'can be sorted by title column' do
      LessonPlan.search(sort: 'title').should eq [@area, @circumference, @dare]
    end

    it 'can be sorted by course name' do
      LessonPlan.search(sort: 'course_name').should eq [@dare, @area, @circumference]
    end

    it 'can be sorted in reverse' do
      LessonPlan.search(sort: 'title', direction: 'desc').should eq [@dare, @circumference, @area]
    end

    it 'can filter and sort' do
      LessonPlan.search(course: 1, sort: 'title').should eq [@area, @circumference]
    end

    it 'can search and sort in reverse' do
      LessonPlan.search(search: 'are', sort: 'title', direction: 'desc').should eq [@dare, @area]
    end
  end
end
