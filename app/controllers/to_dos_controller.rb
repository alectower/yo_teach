class ToDosController < ApplicationController
  before_action :set_to_do, only: [:show, :edit, :update, :destroy]

  def index
    @to_dos = ToDo.all
  end

  def show
  end

  def new
    @to_do = ToDo.new
  end

  def edit
  end

  def create
    @to_do = ToDo.new(to_do_params)

    respond_to do |format|
      if @to_do.save
        format.html { redirect_to @to_do, notice: 'To do was successfully created.' }
        format.json { render action: 'show', status: :created, location: @to_do }
      else
        format.html { render action: 'new' }
        format.json { render json: @to_do.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @to_do.update(to_do_params)
        format.html { redirect_to @to_do, notice: 'To do was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @to_do.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @to_do.destroy
    respond_to do |format|
      format.html { redirect_to to_dos_url }
      format.json { head :no_content }
    end
  end

  private
    def set_to_do
      @to_do = ToDo.find(params[:id])
    end

    def to_do_params
      params[:to_do]
    end
end
