class LessonPlansController < ApplicationController
  before_action :set_lesson_plan,
    only: [:show, :edit, :update, :destroy]

  def index
    search_params = [:sort, :direction, :search, :course]
    search = params.each_key.to_a.keep_if { |p|
      search_params.include?(p.to_sym)
    }
    if search.empty?
      @lesson_plans = current_user.lesson_plans.
        paginate page: params[:page], per_page: 8
    else
      params.each_value do |v|
        v.downcase! if !v.respond_to?(:downcase?)
      end
      @lesson_plans = LessonPlanQuery.new(
        current_user.lesson_plans).search(params).
        paginate page: params[:page], per_page: 8
    end
  end

  def show
    render layout: false
  end

  def new
    @lesson_plan = current_user.lesson_plans.
      new start: start_time, end: end_time
  end

  def edit
  end

  def create
    @lesson_plan = current_user.lesson_plans.
      new(lesson_plan_params)
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
      respond_to do |format|
        format.html do
          flash[:notice] =
            'Lesson plan was successfully updated.'
          redirect_to edit_lesson_plan_path @lesson_plan
        end
        format.js
      end
    else
      respond_to do |format|
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

  def set_lesson_plan
    @lesson_plan = current_user.lesson_plans.
      includes(:course).find(params[:id])
  end

  def lesson_plan_params
    params.require(:lesson_plan).permit :course_id,
      :title, :start, :end, :body
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
