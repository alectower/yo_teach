class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :profile if Rails.env == "development"
  before_filter :authenticate

  private

  def profile
    Rack::MiniProfiler.authorize_request
  end

  def authenticate
    redirect_to new_session_path if !current_user.present?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
