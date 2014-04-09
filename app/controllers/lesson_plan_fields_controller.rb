class LessonPlanFieldsController < ApplicationController

  def destroy
    @lesson_plan_field = LessonPlanField.find(params[:id])
    if @lesson_plan_field.destroy
      flash[:notice] = "#{@lesson_plan_field.title} has been removed from the lesson plan."
    else
      flash[:error] = "#{@lesson_plan_field.title} failed to be removed from the lesson plan."
    end
    redirect_to :back
  end
end
