require 'spec_helper'

describe CoursesController do

  before :each do
    @course = FactoryGirl.create(:course)
  end

  
  it "deletes the course" do
    expect{
      delete :destroy, id: @course, format: 'js'
    }.to change(Course, :count).by(-1)
  end
    
  it "renders the destroy template" do
    delete :destroy, id: @course, format: 'js'
    response.should render_template :destroy
  end

end
