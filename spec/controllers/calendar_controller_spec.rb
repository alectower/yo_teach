require 'spec_helper'

describe CalendarController do
  let(:user) { FactoryGirl.create :user }

  before do
    request.session[:user_id] = user.id
  end

  context 'calendar month' do
    it 'renders the calendar template' do
      get :calendar
      expect(response).to render_template(:month)
    end
  end

  context 'calendar week' do
    it 'creates a calendar object' do
      get :calendar, view: :week
      expect(response).to render_template(:week)
    end
  end
end
