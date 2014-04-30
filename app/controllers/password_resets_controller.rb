class PasswordResetsController < ApplicationController
  skip_filter :authenticate
  layout 'authenticate'

  def new
  end

  def create
    @user = User.find_by email: params[:password_resets][:email]
    if @user
      send_reset_instructions
    else
      flash[:error] = 'The email address entered does not exist in our database.'
      render :new
    end
  end

  def edit
    @user = User.find_by password_reset_token: params[:id]
    if !@user
      redirect_to new_password_reset_path, flash: {
        error: 'Password reset has expired. Please try again.'
      }
    else
      render :edit
    end
  end

  def update
    @user = User.find_by! password_reset_token: params[:id]
    if @user.password_reset_sent_at < 1.hour.ago
      redirect_to new_password_reset_path, flash: {
        error: 'Password reset has expired. Please try again.'
      }
    else
      if @user.update_attributes user_params
        @user.password_reset_token = nil
        @user.password_reset_sent_at = nil
        @user.save
        redirect_to new_session_path, notice:
          'Password has been reset. Please login.'
      else
        render :edit
      end
    end
  end

  private

  def send_reset_instructions
    PasswordResetTokenator.call(@user)
    UserMailer.password_reset(@user).deliver
    redirect_to new_session_path, notice:
      "An email has been sent to #{@user.email} with instructions for resetting your password."
  end

  def user_params
    params.require(:user).permit :password,
      :password_confirmation
  end
end
