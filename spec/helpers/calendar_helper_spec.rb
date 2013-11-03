require 'spec_helper'

describe CalendarHelper do

  describe '#month_view' do
    it 'creates calendar with month param' do
      cal = double("calendar")
      expect(cal).to receive(:new)
        .with(kind_of(DateTime), view: :month)
      month_view(cal)
    end

    it 'returns a calendar object' do
      month_view.should be_a(Calendar)
    end
  end

  describe '#week_view' do
    it 'creates calendar with week param' do
      cal = double("calendar")
      expect(cal).to receive(:new)
        .with(kind_of(DateTime), view: :week)
      week_view(cal)
    end

    it 'returns a calendar object' do
      week_view.should be_a(Calendar)
    end
  end

  describe "#day_hours" do
    let(:base_hours) { [
        { time: "5 AM", lesson: nil },
        { time: "6 AM", lesson: nil },
        { time: "7 AM", lesson: nil },
        { time: "8 AM", lesson: nil },
        { time: "9 AM", lesson: nil },
        { time: "10 AM", lesson: nil },
        { time: "11 AM", lesson: nil },
        { time: "12 PM", lesson: nil },
        { time: "1 PM", lesson: nil },
        { time: "2 PM", lesson: nil },
        { time: "3 PM", lesson: nil },
        { time: "4 PM", lesson: nil },
        { time: "5 PM", lesson: nil },
        { time: "6 PM", lesson: nil },
        { time: "7 PM", lesson: nil },
        { time: "8 PM", lesson: nil },
        { time: "9 PM", lesson: nil },
        { time: "10 PM", lesson: nil },
        { time: "11 PM", lesson: nil }
      ]
    }

    it "creates array of hashes with keys 5am - 11pm" do
      day_hours([]).should == base_hours
    end

    it "creates array with lessons paired with hours" do
      lesson = FactoryGirl.create(:lesson_plan,
         start: DateTime.parse("2013-11-01T12:00:00"))
      base_hours[7] = { time: "12 PM", lesson: lesson }
      day_hours([lesson]).should == base_hours
    end

    it "doesn't add lessons outside of default hours" do
      lesson = FactoryGirl.create(:lesson_plan,
         start: DateTime.parse("2013-11-01T02:00:00"))
      day_hours([lesson]).should == base_hours
    end
  end
end
