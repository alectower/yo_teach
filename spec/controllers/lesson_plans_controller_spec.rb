require 'spec_helper'

describe LessonPlansController do
  let(:user) { FactoryGirl.create :user }
  let(:course) { FactoryGirl.create :course, user: user }
  let(:lesson_plan) { FactoryGirl.create :lesson_plan,
    course: course, user: user }
  let(:invalid_lesson_plan) { FactoryGirl.create :invalid_lesson_plan, course: course, user: user }

  before do
    request.session[:user_id] = user.id
  end

  describe "GET #index" do
    it "populates an array of lesson_plans" do
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
            FactoryGirl.build(:lesson_plan,
              course: course,
              user: user).attributes.symbolize_keys
        }.to change(LessonPlan, :count).by(1)
      end

      it "redirects to the lesson_plans page" do
        l = FactoryGirl.build(:lesson_plan,
              course: course,
              user: user).attributes.symbolize_keys
        post :create, lesson_plan: l
        response.should redirect_to(
          edit_lesson_plan_path(LessonPlan.first.id))
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect{
          post :create, lesson_plan:
            FactoryGirl.build(:invalid_lesson_plan,
              course: course,
              user: user).attributes.symbolize_keys
        }.to_not change(LessonPlan, :count)
      end

      it "re-renders the :new template" do
        post :create, lesson_plan:
          FactoryGirl.build(:invalid_lesson_plan,
            course: course,
            user: user).attributes.symbolize_keys
        response.should render_template :new
      end
    end
  end

  describe "POST #update" do
    it "saves updated fields" do
      lesson_plan.title = 'In class essay'
      put :update, id: lesson_plan,
        lesson_plan: lesson_plan.attributes.symbolize_keys
      LessonPlan.first.title.should eq 'In class essay'
    end

    it 'redirects to edit template' do
      lesson_plan.title = 'In class essay'
      put :update, id: lesson_plan,
        lesson_plan: lesson_plan.attributes.symbolize_keys
      response.should redirect_to(
        edit_lesson_plan_path lesson_plan.id)
    end
  end

  describe "POST #delete" do
    it "renders the destroy template" do
      delete :destroy, id: lesson_plan.id
      response.should redirect_to lesson_plans_path
    end

    it "deletes the lesson_plan" do
      lesson_plan
      expect{
        delete :destroy, id: lesson_plan.id
      }.to change(LessonPlan, :count).by(-1)
    end
  end

  describe "GET #search" do
    it "sets the @lesson_plans variable to the searched for lesson plans" do
      math = FactoryGirl.create :lesson_plan, user: user,
        course: course, title: 'Area'
      get :index, title: 'are'
      assigns(:lesson_plans).size.should eq (1)
    end
  end

end
