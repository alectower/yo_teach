class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.paginate page: params[:page], per_page: 8
  end

  def new
    @course = Course.new
  end

  def show
  end

  def edit
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:notice] = 'Course was successfully created.'
      redirect_to courses_path
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_path,
                      notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @course.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @course.destroy
      respond_to do |format|
        flash[:notice] = 'Course deleted successfully'
        format.html { redirect_to courses_path }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :start_date, :end_date)
    end
end
