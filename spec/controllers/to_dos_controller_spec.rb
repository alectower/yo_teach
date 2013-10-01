require 'spec_helper'

describe ToDosController do

  describe "GET #new" do
    it "assigns a new ToDo to @to_do" do
      get :new, format: :js
      assigns(:to_do).should be_a_new(ToDo)
    end

    it "renders the :new template" do
      get :new, format: :js
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new to_do" do
        expect{
          post :create, to_do:
            FactoryGirl.build(:to_do).attributes.symbolize_keys, format: :js
        }.to change(ToDo,:count).by(1)
      end

      it "redirects to the to_dos page" do
        post :create, to_do:
          FactoryGirl.build(:to_do).attributes.symbolize_keys, format: :js
        response.should render_template :create
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect{
          post :create, to_do:
            FactoryGirl.build(:invalid_to_do).attributes.symbolize_keys, format: :json
        }.to_not change(ToDo, :count)
      end

      it "re-renders the :new template" do
        post :create, to_do:
          FactoryGirl.build(:invalid_to_do).attributes.symbolize_keys, format: :json
        response.should_not be_success
      end
    end
  end

  describe "POST #delete" do
    it "renders the destroy template" do
      to_do = FactoryGirl.create(:to_do)
      delete :destroy, id: to_do.id, format: :json
      response.should be_success
    end

    it "deletes the to_do" do
      to_do = FactoryGirl.create(:to_do)
      expect{
        delete :destroy, id: to_do.id, format: :json
      }.to change(ToDo, :count).by(-1)
    end
  end

end
