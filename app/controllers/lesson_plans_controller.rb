class LessonPlansController < ApplicationController
  before_action :set_lesson_plan, only: [:edit, :update, :destroy]

  TIME_FORMAT = "%Y-%m-%dT%H:%M"

  def index
    search_params = [:sort, :direction, :search, :course]
    search = params.each_key.to_a.keep_if { |p|
      search_params.include?(p.to_sym)
    }
    if search.empty?
      @lesson_plans = LessonPlan.all
    else
      params.each_value do |v|
        v.downcase! if !v.respond_to?(:downcase?)
      end
      @lesson_plans = LessonPlanQuery.new.search(params)
    end
  end

  def new
    now = 8.hours.since DateTime.now.beginning_of_day
    start_time = params.fetch(:start) { now }
      .strftime(TIME_FORMAT)
    end_time = params.fetch(:end) { 1.hour.since(now) }
      .strftime(TIME_FORMAT)
    @lesson_plan = LessonPlan.new(start: start_time,
                                  end: end_time)
    build_default_fields
  end

  def edit
    @lesson_plan.fields.build
  end

  def create
    @lesson_plan = LessonPlan.new(lesson_plan_params)
    respond_to do |format|
      if @lesson_plan.save
        flash[:notice] =
          'Lesson plan was successfully created.'
        format.html { redirect_to(
                      edit_lesson_plan_path @lesson_plan)}
        format.json { render :show,
                  status: :created,
                  location: @lesson_plan }
      else
        flash[:error] =
          'Lesson plan failed to be created.'
        format.html { render :new }
        format.json { render json: @lesson_plan.errors,
                  status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lesson_plan.update(lesson_plan_params)
        flash[:notice] =
          'Lesson plan was successfully updated.'
        format.html { redirect_to(
                      edit_lesson_plan_path @lesson_plan)}
        format.json { head :no_content }
      else
        flash[:error] =
          'Lesson plan failed to be updated.'
        format.html { render :new }
        format.json { render json: @lesson_plan.errors,
                  status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @lesson_plan.destroy
      flash[:notice] =
        'Lesson plan was successfully deleted.'
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
    ].sort.each do |field|
      @lesson_plan.fields.build title: field
    end
    @lesson_plan.fields.build
  end

  def set_lesson_plan
    @lesson_plan = LessonPlanQuery.new
      .lesson_plan_with_fields(params[:id])
  end

  def lesson_plan_params
    params.require(:lesson_plan)
      .permit(:course_id,
              :title,
              :start,
              :end,
              :status,
              fields_attributes: [:id,
                                  :title,
                                  :description])
  end

end
