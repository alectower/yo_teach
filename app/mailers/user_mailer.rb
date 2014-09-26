class UserMailer < ActionMailer::Base
  default from:
    "#{I18n.t :app_name} <#{I18n.t :noreply_email}>"

  def new_user(user)
    @user = user
    mail_to_user "#{t :app_name} Sign Up"
  end

  def user_update(user)
    @user = user
    mail_to_user "#{t :app_name} User Update"
  end

  def password_update(user)
    @user = user
    mail_to_user "#{t :app_name} Password Update"
  end

  def password_reset(user)
    @user = user
    @token = user.password_reset_token
    mail_to_user "#{t :app_name} Password Reset"
  end

  private

  def mail_to_user(subject)
    to = "#{@user.name} <#{@user.email}>"
    mail to: to, subject: subject do |format|
      format.text
      format.html
    end
  end
end
