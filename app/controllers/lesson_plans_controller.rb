class LessonPlansController < ApplicationController
  before_action :set_lesson_plan, only: [:edit, :update, :destroy]

  def index
    search_params = [:sort, :direction, :search, :course]
    search = params.each_key.to_a.keep_if { |p|
      search_params.include?(p.to_sym)
    }
    if search.empty?
      @lesson_plans = LessonPlan.paginate page: params[:page], per_page: 8
    else
      params.each_value do |v|
        v.downcase! if !v.respond_to?(:downcase?)
      end
      @lesson_plans = LessonPlanQuery.new.search(params).paginate page: params[:page], per_page: 8
    end
  end

  def new
    @lesson_plan =
      LessonPlan.new start: start_time, end: end_time
    build_default_fields
  end

  def edit
    @lesson_plan.fields.build
  end

  def create
    @lesson_plan = LessonPlan.new(lesson_plan_params)
    if @lesson_plan.save
      flash[:notice] =
        'Lesson plan was successfully created.'
      redirect_to edit_lesson_plan_path(@lesson_plan)
    else
      flash[:error] =
        'Lesson plan failed to be created.'
      render :new
    end
  end

  def update
    if @lesson_plan.update(lesson_plan_params)
      response do |format|
        format.html do
          flash[:notice] =
            'Lesson plan was successfully updated.'
          redirect_to edit_lesson_plan_path @lesson_plan
        end
        format.js
      end
    else
      response do |format|
        format.html do
          flash[:error] =
            'Lesson plan failed to be updated.'
          render :edit
        end
        format.js
      end
    end
  end

  def destroy
    if @lesson_plan.destroy
      flash[:notice] =
        'Lesson plan was successfully deleted.'
      redirect_to lesson_plans_path
    else
      flash[:notice] =
        'Lesson plan failed to be deleted.'
      render :edit
    end
  end

  private

  def build_default_fields
    %w[
      Objectives Activities Assessments Homework
    ].sort.each do |field|
      @lesson_plan.fields.build title: field
    end
    @lesson_plan.fields.build
  end

  def set_lesson_plan
    @lesson_plan = LessonPlanQuery.new.
      lesson_plan_with_fields(params[:id])
  end

  def lesson_plan_params
    params.require(:lesson_plan).permit(:course_id,
      :title, :start, :end,
      fields_attributes: [:id, :title, :description])
  end

  def start_time
    @now ||= 8.hours.since Date.today.beginning_of_day
    @start_time ||= params.fetch(:start) { @now }.
      to_datetime
  end

  def end_time
    params.fetch(:end) { 1.hour.since(@now) }.
      to_datetime
  end

end
