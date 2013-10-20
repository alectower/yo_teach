require 'spec_helper'

describe LessonPlansController do

  describe "GET #index" do
    it "populates an array of lesson_plans" do
      lesson_plan = FactoryGirl.create(:lesson_plan)
      get :index
      assigns(:lesson_plans).should eq([lesson_plan])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #new" do
    it "assigns a new LessonPlan to @lesson_plan" do
      get :new
      assigns(:lesson_plan).should be_a_new(LessonPlan)
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new lesson_plan" do
        expect{
          post :create, lesson_plan:
            FactoryGirl.build(:lesson_plan)
              .attributes.symbolize_keys
        }.to change(LessonPlan, :count).by(1)
      end

      it "redirects to the lesson_plans page" do
        l = FactoryGirl.build(:lesson_plan)
          .attributes.symbolize_keys
        post :create, lesson_plan: l
        response.should redirect_to(
          edit_lesson_plan_path(LessonPlan.first.id))
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect{
          post :create, lesson_plan:
            FactoryGirl.build(:invalid_lesson_plan)
              .attributes.symbolize_keys
        }.to_not change(LessonPlan, :count)
      end

      it "re-renders the :new template" do
        post :create, lesson_plan:
          FactoryGirl.build(:invalid_lesson_plan)
            .attributes.symbolize_keys
        response.should render_template :new
      end
    end
  end

  describe "POST #update" do
    it "saves updated fields" do
      l = FactoryGirl.create(:lesson_plan)
      l.title = 'In class essay'
      put :update, id: l,
        lesson_plan: l.attributes.symbolize_keys
      LessonPlan.first.title.should eq 'In class essay'
    end

    it 'redirects to edit template' do
      l = FactoryGirl.create(:lesson_plan)
      l.title = 'In class essay'
      put :update, id: l,
        lesson_plan: l.attributes.symbolize_keys
      response.should redirect_to(
        edit_lesson_plan_path l.id)
    end
  end

  describe "POST #delete" do
    it "renders the destroy template" do
      lesson_plan = FactoryGirl.create(:lesson_plan)
      delete :destroy, id: lesson_plan.id
      response.should redirect_to lesson_plans_path
    end

    it "deletes the lesson_plan" do
      lesson_plan = FactoryGirl.create(:lesson_plan)
      expect{
        delete :destroy, id: lesson_plan.id
      }.to change(LessonPlan, :count).by(-1)
    end
  end

  describe "GET #search" do
    it "sets the @lesson_plans variable to the searched for lesson plans" do
      math = FactoryGirl.create(:lesson_plan,
                                title: 'Area')
      get :index, title: 'are'
      assigns(:lesson_plans).size.should eq (1)
    end
  end

end
