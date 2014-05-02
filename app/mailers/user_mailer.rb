class UserMailer < ActionMailer::Base
  default from:
    "#{I18n.t :app_name} <#{I18n.t :noreply_email}>"

  def new_user(user)
    @user = user
    mail_to_user "#{t :app_name} sign up"
  end

  def user_update(user)
    @user = user
    mail_to_user "#{t :app_name} user update"
  end

  def password_update(user)
    @user = user
    mail_to_user "#{t :app_name} password update"
  end

  def password_reset(user)
    @user = user
    @token = user.password_reset_token
    mail_to_user "#{t :app_name} password reset"
  end

  private

  def mail_to_user(subject)
    mail to: "#{@user.name} <#{@user.email}>",
      subject: subject
  end
end
