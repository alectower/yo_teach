class LessonPlansController < ApplicationController
  before_action :set_lesson_plan, only: [:show, :edit, :update, :destroy]

  def index
    @lesson_plans = LessonPlan.all
  end

  def show
  end

  def new
    @lesson_plan = LessonPlan.new
    now = DateTime.now
    @lesson_plan.start = params.fetch(:start) { now }
		@lesson_plan.end = params.fetch(:end) { 1.hour.since(now) }
  end

  def edit
  end

  def create
    @lesson_plan = LessonPlan.new(lesson_plan_params)
    respond_to do |format|
      if @lesson_plan.save
        format.html { redirect_to lesson_plans_path, 
        							notice: 'Lesson plan was successfully created.' }
        format.json { render action: 'show', 
        							status: :created, location: @lesson_plan }
      else
        format.html { render action: :new }
        format.json { render json: @lesson_plan.errors, 
        							status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lesson_plan.update(lesson_plan_params)
        format.html { redirect_to lesson_plans_path, 
        							notice: 'Lesson plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lesson_plan.errors, 
        							status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @lesson_plan.destroy
			flash[:notice] = 'Lesson plan deleted successfully' 
			respond_to do |format|
				format.html { redirect_to lesson_plans_path }
				format.json { head :no_content }
			end
		end
  end

  private
    def set_lesson_plan
      @lesson_plan = LessonPlan.find(params[:id])
    end

    def lesson_plan_params
      params.require(:lesson_plan)
				.permit(:course_id, :description, :start, :end)
    end
end
