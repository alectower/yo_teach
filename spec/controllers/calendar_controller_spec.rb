require 'spec_helper'

describe CalendarController do
  describe "GET #index" do
    it "populates a calendar day array with courses" do
      course = FactoryGirl.create(:course)
      get :index
      assigns(:calendar).courses.should match_array([course])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
