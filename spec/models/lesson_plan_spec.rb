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
    FactoryGirl.build(:lesson_plan, user:user, end: nil)
      .should_not be_valid
  end

  context "created with empty field descriptions" do
    it "is created with an empty status" do
      FactoryGirl.create(:lesson_plan, user: user).status
        .should eq LessonPlan::EMPTY
    end
  end

  context "created with some field descriptions" do
    it "is created with an in progress status" do
      l = FactoryGirl.build(:lesson_plan, user: user)
      l.fields.build title: 'Homework',
        description: 'Read'
      l.fields.build title: 'Activities', description: nil
      l.save
      l.status.should eq LessonPlan::IN_PROGRESS
    end
  end

  context "created with non-empty field descriptions" do
    it "is created with an complete status" do
      l = FactoryGirl.build(:lesson_plan, user: user)
      l.fields.build title: 'Homework',
        description: 'Read'
      l.fields.build title: 'Activities', description: 'Discuss Reading'
      l.save
      l.status.should eq LessonPlan::COMPLETE
    end
  end

  context "when searching for a lesson plan" do
    before do
      math = FactoryGirl.create :course, user: user,
        name: 'Math'
      english = FactoryGirl.create :course, user: user,
        name: 'English'
      @area = FactoryGirl.create :lesson_plan, user: user,
         title: 'Area', course: math
      @dare = FactoryGirl.create :lesson_plan, user: user,
        title: 'Dare to be Great', course: english
      @circumference = FactoryGirl.create :lesson_plan,
        user: user, title: "Circumference", course: math
    end
  end
end
