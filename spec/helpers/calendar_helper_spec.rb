require 'spec_helper'

describe CalendarHelper do

  it 'returns a calendar object' do
    month_view.should be_a(Calendar)
    week_view.should be_a(Calendar)
  end

end
