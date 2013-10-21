class LessonPlanFieldsController < ApplicationController

  def destroy
    @lesson_plan_field = LessonPlanField.find(params[:id])
    if @lesson_plan_field.destroy
      flash[:success] = "You have removed #{@lesson_plan_field.title}
                         from the lesson plan."
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    end
  end
end