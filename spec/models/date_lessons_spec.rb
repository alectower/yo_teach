require 'spec_helper'

describe DateLessons do

  it 'retrieves lesson plans for current month' do
    DateLessons.new.range(:month).size.should eq 35
  end

  it '' do
  end

end
