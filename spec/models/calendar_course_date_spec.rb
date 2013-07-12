require 'spec_helper'

describe CalendarCourseDate do
  it "doesn't store courses that don't match the day of week" do
    date = Date.new(1984,6,26)
    course = FactoryGirl.create(:course)
    CalendarCourseDate.new(date).courses.should eq([])
  end

  it "stores courses that match the day of week" do
    date = Date.new(1984,6,26).tomorrow.tomorrow
    course = FactoryGirl.create(:course)
    CalendarCourseDate.new(date).courses.should eq([course])
  end

end
