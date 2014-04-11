require 'active_support/core_ext/date/calculations'
require_relative '../../app/services/calendar'

describe Calendar do

  before :each do
    @date = DateTime.new(1984, 6, 26)
    @cal = Calendar.new user: nil, date: @date,
      view: :month
  end

  it 'has the current month' do
    @cal.month.should eq('June')
  end

  it 'has the current year' do
    @cal.year.should eq(1984)
  end

  it 'has the previous month' do
    @cal.prev_month.should eq DateTime.new(1984, 5, 26)
  end

  it 'has next month' do
    @cal.next_month.should eq DateTime.new(1984, 7, 26)
  end

end


