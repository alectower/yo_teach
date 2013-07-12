require 'spec_helper'

describe Calendar do
  before :each do
    @course = FactoryGirl.create(:course)
    @cal = CourseCalendar.new(courses: [@course], date: Date.new(1984,6,26))
  end
  
  it "knows the current month" do
    @cal.current_month.should eq("June")
  end

  it "holds courses related to days they are scheduled" do
    @cal.dates[4].courses.should match_array([@course])
  end

end

