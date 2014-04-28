class UserMailerPreview < ActionMailer::Preview
  def new_user
    UserMailer.new_user(User.first)
  end

  def email_update
    UserMailer.email_update(User.first)
  end

  def password_update
    UserMailer.password_update(User.first)
  end
end
