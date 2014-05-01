class UserMailerPreview < ActionMailer::Preview
  def new_user
    UserMailer.new_user(User.first)
  end

  def user_update
    UserMailer.user_update(User.first)
  end

  def password_update
    UserMailer.password_update(User.first)
  end
end
