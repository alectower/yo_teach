class LessonPlanStandardsController < ApplicationController
  before_filter :set_lesson_plan

  def create
    @lesson_plan.core_standard_ids +=
      [params[:core_standard_id]]
    redirect_to edit_lesson_plan_path(@lesson_plan)
  end

  def destroy
    @lesson_plan.core_standard_ids -=
      [params[:core_standard_id].to_i]
    redirect_to edit_lesson_plan_path(@lesson_plan)
  end

  private

  def set_lesson_plan
    @lesson_plan = LessonPlan.find params[:lesson_plan_id]
  end
end
