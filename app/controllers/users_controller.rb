class UsersController < ApplicationController
  skip_filter :authenticate, only: [:new, :create]
  layout 'authenticate'

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'You have successfully signed up.'
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :password,
      :password_confirmation
  end
end
