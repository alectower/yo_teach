class ToDosController < ApplicationController
  before_action :set_to_do, only: [:destroy]

  def new
    @to_do = ToDo.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @to_do = ToDo.new(to_do_params)
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
      @to_do = ToDo.find(params[:id])
    end

    def to_do_params
      params.require(:to_do).permit(:body)
    end
end
