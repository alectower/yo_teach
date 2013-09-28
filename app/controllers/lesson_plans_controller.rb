class LessonPlansController < ApplicationController
  before_action :set_lesson_plan, only: [:show, :edit, :update, :destroy]

	TIME_FORMAT = "%Y-%m-%dT%H:%M"

  def index
    @lesson_plans = LessonPlan.all
  end

  def show
  end

  def new
    @lesson_plan = LessonPlan.new
    now = 8.hours.since DateTime.now.beginning_of_day
    @lesson_plan.start = params.fetch(:start) { now }.strftime(TIME_FORMAT)
		@lesson_plan.end = params.fetch(:end) { 1.hour.since(now) }.strftime(TIME_FORMAT)
		build_default_fields
	end

  def edit
		@lesson_plan.fields.build
  end

  def create
    @lesson_plan = LessonPlan.new(lesson_plan_params)
    respond_to do |format|
      if @lesson_plan.save
				flash[:notice] = 'Lesson plan was successfully created.'
        format.html { redirect_to edit_lesson_plan_path @lesson_plan.id }
        format.json { render :show,
        		status: :created, location: @lesson_plan }
      else
        format.html { render :new }
        format.json { render json: @lesson_plan.errors,
        							status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lesson_plan.update(lesson_plan_params)
        flash[:notice] = 'Lesson plan was successfully updated.'
        format.html { redirect_to edit_lesson_plan_path @lesson_plan.id }
        format.json { head :no_content }
      else
        format.html { render :edit }
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

  	def build_default_fields
			%w[ Objectives 
					Activities 
					Assessments 
					Homework 
					Standards
			].each do |field|
				@lesson_plan.fields.build title: field
			end
			@lesson_plan.fields.build 
		end

    def set_lesson_plan
      @lesson_plan = LessonPlan.lesson_plan_with_fields(params[:id])
    end

    def lesson_plan_params
      params.require(:lesson_plan)
				.permit(:course_id,
								:title,
								:start,
								:end,
								fields_attributes: [:title, :description])
    end

end
