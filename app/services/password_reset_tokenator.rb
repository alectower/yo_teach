class PasswordResetTokenator
  def self.call(user)
    begin
      token = SecureRandom.urlsafe_base64
      user.password_reset_token = token
    end while User.exists?(password_reset_token: token)
    user.password_reset_sent_at = Time.zone.now
    user.save!
  end
end
