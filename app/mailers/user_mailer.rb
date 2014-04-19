class UserMailer < ActionMailer::Base
  default from: 'noreply@lessonmate.com'

  def new_user(user)
    @user = user
    mail to: user.email, subject: 'Lesson Mate sign up'
  end

  def email_update(user)
    mail to: user.email,
      subject: 'Lesson Mate email update'
  end

  def password_update(user)
    mail to: user.email,
      subject: 'Lesson Mate password update'
  end
end
