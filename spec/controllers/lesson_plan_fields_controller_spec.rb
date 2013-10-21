require 'spec_helper'

describe LessonPlanFieldsController do

  describe 'DELETE destroy' do

    before { request.env["HTTP_REFERER"] = "where_i_came_from" }

    let(:lesson_plan_field) { FactoryGirl.create(:lesson_plan_field) }

    it 'sets the variable to the correct lesson plan' do
      delete :destroy, id: lesson_plan_field.id
      expect(assigns(:lesson_plan_field)).to eq(lesson_plan_field)
    end

    it 'deletes the field from the lesson plan' do
      delete :destroy, id: lesson_plan_field.id
      expect(LessonPlanField.count).to eq(0)
    end

    it 'sets the flash success' do
      delete :destroy, id: lesson_plan_field.id
      expect(flash[:success]).to be_present
    end

    it 'redirects to the previous page' do
      delete :destroy, id: lesson_plan_field.id
      expect(response).to redirect_to "where_i_came_from"
    end
  end
end