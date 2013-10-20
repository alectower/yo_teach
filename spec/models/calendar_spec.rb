require 'spec_helper'

describe Calendar do
  before :each do
    @date = DateTime.new(1984, 6, 26)
  end

  context 'for specific date' do
    before do
      @cal = Calendar.new @date
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

  it 'has the first date to be displayed on the calendar' do
    Calendar.first_of_month(@date).should eq(DateTime.new(1984,5,27))
  end

end


