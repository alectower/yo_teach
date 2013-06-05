require 'spec_helper'

describe MainController do

  describe "GET 'main'" do
    it "returns http success" do
      get :main
      response.should be_success
    end

    it 'renders the main template' do
      get :main
      expect(response).to render_template('main')
    end

    it "loads services for main view" do
      get :main
      expect(@services)
    end
  end

end
