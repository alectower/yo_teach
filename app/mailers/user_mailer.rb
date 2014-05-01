class UserMailer < ActionMailer::Base
  default from: I18n.t(:noreply_email)

  def new_user(user)
    @user = user
    mail to: user.email, subject:
      "#{t :app_name} sign up"
  end

  def user_update(user)
    @user = user
    mail to: user.email, subject:
      "#{t :app_name} user update"
  end

  def password_update(user)
    @user = user
    mail to: user.email, subject:
      "#{t :app_name} password update"
  end
end
