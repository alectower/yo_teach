class CoursesController < ApplicationController

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new strong_params(params[:course])
    if @course.save
      flash[:notice] = 'Course was successfully created.' 
      redirect_to root_url
    else
      render action: :new
    end
  end

  def show
    
  end

  def destroy
    @course = Course.find(params[:id])

    if @course.destroy
      flash[:notice] = 'Course deleted successfully' 
      redirect_to root_url
    end

  end

  private

    def strong_params(params) 
      params.permit(:name, :start_date, :end_date, :start_time, :end_time)
    end
end
