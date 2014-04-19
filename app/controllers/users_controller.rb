class UsersController < ApplicationController
  skip_filter :authenticate, only: [:new, :create]
  layout 'authenticate', only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = 'You have successfully signed up. Please login.'
      redirect_to new_session_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update user_params
      flash[:notice] =
        'User information has been successfully updated.'
      redirect_to account_path(current_user.account)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :password,
      :password_confirmation
  end
end
