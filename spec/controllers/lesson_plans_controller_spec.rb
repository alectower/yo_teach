require 'spec_helper'

describe LessonPlansController do

	let(:lesson_plan) { FactoryGirl.create(:lesson_plan) }
	let(:valid_attributes) { FactoryGirl.attributes_for(:lesson_plan) }

  describe "GET index" do
    it "assigns all lesson_plans as @lesson_plans" do
      get :index 
      assigns(:lesson_plans).should eq([lesson_plan])
    end
  end

  describe "GET show" do
    it "assigns the requested lesson_plan as @lesson_plan" do
      get :show, {:id => lesson_plan.to_param}
      assigns(:lesson_plan).should eq(lesson_plan)
    end
  end

  describe "GET new" do
    it "assigns a new lesson_plan as @lesson_plan" do
      get :new
      assigns(:lesson_plan).should be_a_new(LessonPlan)
    end
  end

  describe "GET edit" do
    it "assigns the requested lesson_plan as @lesson_plan" do
      get :edit, {:id => lesson_plan.to_param}
      assigns(:lesson_plan).should eq(lesson_plan)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new LessonPlan" do
        expect {
          post :create, {:lesson_plan => valid_attributes}
        }.to change(LessonPlan, :count).by(1)
      end

      it "assigns a newly created lesson_plan as @lesson_plan" do
        post :create, {:lesson_plan => valid_attributes}
        assigns(:lesson_plan).should be_a(LessonPlan)
        assigns(:lesson_plan).should be_persisted
      end

      it "redirects to the created lesson_plan" do
        post :create, {:lesson_plan => valid_attributes }
        response.should redirect_to(LessonPlan.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved lesson_plan as @lesson_plan" do
        LessonPlan.any_instance.stub(:save).and_return(false)
        post :create, { :lesson_plan => valid_attributes }
        assigns(:lesson_plan).should be_a_new(LessonPlan)
      end

      it "re-renders the 'new' template" do
        LessonPlan.any_instance.stub(:save).and_return(false)
        post :create, {:lesson_plan => valid_attributes}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested lesson_plan" do
        LessonPlan.any_instance.should_receive(:update)
        	.with("description" => 'New Name')
        put :update, {:id => lesson_plan.to_param, 
						:lesson_plan => { description: "New Name" }}
      end

      it "assigns the requested lesson_plan as @lesson_plan" do
        put :update, {:id => lesson_plan.to_param, 
        							:lesson_plan => valid_attributes}
        assigns(:lesson_plan).should eq(lesson_plan)
      end

      it "redirects to the lesson_plan" do
        put :update, {:id => lesson_plan.to_param, 
        							:lesson_plan => valid_attributes}
        response.should redirect_to(lesson_plan)
      end
    end

    describe "with invalid params" do
      it "assigns the lesson_plan as @lesson_plan" do
        LessonPlan.any_instance.stub(:save).and_return(false)
        put :update, {:id => lesson_plan.to_param, 
        							:lesson_plan => valid_attributes}
        assigns(:lesson_plan).should eq(lesson_plan)
      end

      it "re-renders the 'edit' template" do
        LessonPlan.any_instance.stub(:save).and_return(false)
        put :update, {:id => lesson_plan.to_param, 
        							:lesson_plan => valid_attributes}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested lesson_plan" do
    	lesson_plan
      expect {
        delete :destroy, {:id => lesson_plan.to_param}
      }.to change(LessonPlan, :count).by(-1)
    end

    it "redirects to the lesson_plans list" do
      delete :destroy, {:id => lesson_plan.to_param}
      response.should redirect_to(lesson_plans_url)
    end
  end

end
