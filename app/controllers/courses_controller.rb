class CoursesController < ApplicationController

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
 
    respond_to do |format|
      format.js
    end
  end

  def create
    @course = Course.new(strong_params(params[:course]))
    respond_to do |format|
      if @course.save
        flash[:notice] = 'Course created successfully' 
        format.js
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])
      
    respond_to do |format|
      if @course.destroy
        flash[:notice] = 'Course deleted successfully' 
        format.js
      end
    end
  end

  private

    def strong_params(params) 
      params.permit(:name, :start_date, :end_date, :start_time, :end_time)
    end
end
