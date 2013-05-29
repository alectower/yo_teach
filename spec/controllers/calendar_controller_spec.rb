require 'spec_helper'

describe CalendarController do
  
  it "knows the first day of the month" do
    cal = CalendarController.new
    date = Date.today
    cal.first_of_month(date).should eql 1
  end

end
