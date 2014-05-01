module Auth
  def authenticate
    redirect_to new_session_path if !active_user?
  end

  def active_user?
    current_user && !current_user.locked?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
  end
end
