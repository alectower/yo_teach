require 'spec_helper'

describe "LessonPlans" do

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
      page.should have_content /Objectives/
      page.should have_content /Activities/
      page.should have_content /Assessments/
      page.should have_content /Homework/
      page.should have_content /Standards/
      page.should have_content /Add/
    end

    context "course exists" do
      it "creates a valid lesson plan" do
        FactoryGirl.create(:course, name: 'Math')
        expect {
          visit new_lesson_plan_path
          within '#details-tab' do
            select 'Math', from: 'Course'
            fill_in 'Lesson Title', with: 'Mitosis'
            fill_in 'Start', with: DateTime.now
            fill_in 'End', with: 1.hour.since(DateTime.now)
          end
          click_button 'Create Lesson Plan'
        }.to change(LessonPlan, :count).by(1)
        LessonPlan.first.status.should eq 1
      end

      context "content tab" do
        before :each do
          FactoryGirl.create :course, name: 'Math'
          visit new_lesson_plan_path
          within "#details-tab" do
            select 'Math', from: 'Course'
            fill_in 'Lesson Title', with: 'Mitosis'
            fill_in 'Start', with: DateTime.now
            fill_in 'End', with: 1.hour.since(DateTime.now)
          end
          click_link 'Add'
        end

        context "new custom lesson plan field" do
          it "associates field with lesson plan" do
            expect {
              page.should have_content /Add/
              within '#add-tab' do
                fill_in 'Title', with: 'Homework'
                fill_in 'Description', with: 'Read ch. 1-3'
              end
              click_button 'Create Lesson Plan'
            }.to change(LessonPlanField, :count).by(6)
          end
        end

        context "custom lesson plan field without title" do
          it "doesn't create blank titled lesson fields" do
            expect {
              within '#add-tab' do
                fill_in 'Title', with: ''
              end
              click_button 'Create Lesson Plan'
            }.to change(LessonPlanField, :count).by 5
          end
        end
      end
    end
  end

  describe 'edit lesson plan' do
    let(:datetime) { DateTime.now }
    before :each do
      c = FactoryGirl.create :course_with_lesson_plan_field
      visit edit_lesson_plan_path c.lesson_plans.first.id
    end

    it "displays lesson plan info in title" do
      within '.heading' do
        page.should have_content /Area/
        page.should have_content /Math/
        page.should have_content Date::DAYNAMES[datetime.to_date.wday]
        page.should have_content datetime.to_date
      end
    end
  end

  describe 'user searches for lesson plan(s)' do
    it "returns the correct lesson plan(s)" do
      math = FactoryGirl.create :course
      math.lesson_plans << FactoryGirl.create(:lesson_plan, title: "Area")
      math.lesson_plans << FactoryGirl.create(:lesson_plan, title: "Barely Multiplication")
      math.lesson_plans << FactoryGirl.create(:lesson_plan, title: "Circumference")
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
