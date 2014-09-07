class UsersController < ApplicationController
  skip_filter :authenticate, only: [:new, :create]
  layout 'authenticate', only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params.merge(password_params)
    if @user.save
      UserMailer.new_user(@user).deliver
      redirect_to new_session_path, notice:
        'You have successfully signed up. Please login.'
    else
      render :new
    end
  end

  def show
  end

  def edit_user
  end

  def edit_password
  end

  def update_user
    if current_user.update user_params
      UserMailer.user_update(current_user).deliver
      redirect_to user_path(current_user), notice:
        'User information has been successfully updated.'
    else
      render :edit_user
    end
  end

  def update_password
    password = params[:user][:old_password]
    if current_user.authenticate(password) && current_user.update(password_params)
      UserMailer.password_update(current_user).deliver
      redirect_to user_path(current_user), notice:
        'User password has been successfully updated.'
    else
      render_update_password_fail
    end
  end

  private

  def render_update_password_fail
    flash[:error] = 'Old password is incorrect or new password does not match password confirmation'
    render :edit_password
  end

  def user_params
    params.require(:user).permit :name, :email
  end

  def password_params
    params.require(:user).permit :password,
      :password_confirmation
  end

end
