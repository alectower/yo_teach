require 'spec_helper'

describe CalendarController do
  describe "GET #month" do
    it "creates a calendar object" do
      get :month
      assigns(:calendar).should be_a(Calendar)
    end

    it "populates the to-do list" do
      to_do = FactoryGirl.create(:to_do)
      get :month
      assigns(:to_dos).should match_array([to_do])
    end

    it "renders the index template" do
      get :month
      expect(response).to render_template(:calendar)
		end

    it "creates a calendar for a specific month" do
      get :month, month: 7, year: 2013
      assigns(:calendar).month.should eq("July")
    end
  end
end
