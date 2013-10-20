require 'spec_helper'

describe CalendarController do
  context 'calendar month' do
    it 'creates a calendar object' do
      get :calendar
      assigns(:calendar).should be_a(Calendar)
    end

    it 'populates the to-do list' do
      to_do = FactoryGirl.create(:to_do)
      get :calendar
      assigns(:to_dos).should match_array([to_do])
    end

    it 'renders the index template' do
      get :calendar
      expect(response).to render_template(:calendar)
    end

    it 'creates a calendar for a specific calendar' do
      get :calendar, date: '2013-07-01'
      assigns(:calendar).month.should eq('July')
    end
  end

  context 'calendar week' do
    it 'creates a calendar object' do
      get :calendar, view: :week
      assigns(:calendar).should be_a(Calendar)
    end
  end
end
