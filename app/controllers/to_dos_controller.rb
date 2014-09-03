class ToDosController < ApplicationController
  before_action :set_to_do, only: [:destroy]

  def new
    @to_do = current_user.to_dos.new
  end

  def create
    @to_do = current_user.to_dos.new to_do_params
    respond_to do |format|
      if @to_do.save
        format.js
      else
        format.json { render json: @to_do.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @to_do.destroy
    respond_to do |format|
      format.json { render json: {}}
    end
  end

  private
    def set_to_do
      @to_do = current_user.to_dos.find params[:id]
    end

    def to_do_params
      params.require(:to_do).permit :body
    end
end
