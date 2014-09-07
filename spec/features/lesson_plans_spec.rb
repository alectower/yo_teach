require 'spec_helper'
require 'support/authenticate'

describe "LessonPlans" do
  include Authenticate

  let(:user) { FactoryGirl.create :user }

  before do
    log_in
  end

  describe "view lesson plans page" do
    it "displays lesson plans and their attribtues" do
      visit lesson_plans_path
      page.should have_content /Lesson Plan Title/
      page.should have_content /Status/
      page.should have_content /Course/
      page.should have_content /Date/
      page.should have_content /Start Time/
      page.should have_content /End Time/
    end
  end

  describe "create new lesson plan" do

    it "displays navigation links" do
      visit new_lesson_plan_path
      page.should have_content /Details/
    end

    it "creates a valid lesson plan" do
      expect {
        visit new_lesson_plan_path
        within '#details-tab' do
          fill_in 'Course', with: 'Math'
          fill_in 'Lesson Title', with: 'Mitosis'
          fill_in 'Start', with: DateTime.now
          fill_in 'End', with: 1.hour.since(DateTime.now)
        end
        click_button 'Create Lesson Plan'
      }.to change(LessonPlan, :count).by(1)
      LessonPlan.first.complete.should eq false
    end
  end

  describe 'edit lesson plan' do
    let(:start_time) { Time.parse "2013-06-26 09:00:00" }
    let(:end_time) { 1.hour.since start_time}
    let(:lesson) { FactoryGirl.create :lesson_plan,
      user: user, start: start_time, end: end_time }

    it "displays lesson plan info in title" do
      visit edit_lesson_plan_path lesson.id
      within '.heading' do
        page.should have_content /Area/
        page.should have_content /Math/
      end
    end
  end

  describe 'user searches for lesson plan(s)' do
    it "returns the correct lesson plan(s)" do
      FactoryGirl.create :lesson_plan, user: user,
       title: "Area"
      FactoryGirl.create :lesson_plan, user: user,
        title: "Barely Multiplication"
      FactoryGirl.create :lesson_plan, user: user,
        title: "Circumference"
      visit lesson_plans_path
      page.should have_content /Lesson Plans/
      page.should have_content /Area/
      page.should have_content /Barely Multiplication/
      page.should have_content /Circumference/
      fill_in "search", with: "are"
      click_button "Search"
      page.should_not have_content("Circumference")
    end
  end
end
