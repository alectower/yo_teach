require 'spec_helper'

describe CourseCalendar do
  before :each do
    @course = FactoryGirl.create(:course)
    @cal = CourseCalendar.new(courses: [@course])
  end
  
  it "knows the current month" do
    Date.any_instance.stub(:today).and_return(Date.new(1984,6,26))
    @cal.current_month.should eq("June")
  end

  it "holds courses related to days they are scheduled" do
    @cal.days.should eq({ 4 => [@course] })
  end

end

