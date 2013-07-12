require 'spec_helper'

describe CalendarController do
  describe "GET #index" do
    it "populates a calendar day array with courses" do
      course = FactoryGirl.create(:course)
      get :index
      assigns(:calendar).dates[4].courses.should match_array([course])
    end

    it "populates the to-do list" do
      to_do = FactoryGirl.create(:to_do)
      get :index
      assigns(:to_dos).should match_array([to_do])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
