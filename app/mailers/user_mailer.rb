class UserMailer < ActionMailer::Base
  default from: 'noreply@lessonmate.com'

  def new_user(user)
    @user = user
    mail to: user.email, subject:
      "#{Rails.configuration.app_name} sign up"
  end

  def user_update(user)
    @user = user
    mail to: user.email, subject:
      "#{Rails.configuration.app_name} user update"
  end

  def password_update(user)
    @user = user
    mail to: user.email, subject:
      "#{Rails.configuration.app_name} password update"
  end
end
