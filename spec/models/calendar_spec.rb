require 'spec_helper'

describe Calendar do
  before :each do
    @date = Date.new(1984,6,26)
    @cal = Calendar.new @date
  end
  
  it "knows the current month" do
    @cal.month.should eq("June")
  end

  it "knows the first date to be displayed on the calendar" do
    @cal.first_date.should eq(Date.new(1984,5,27))
  end
end

