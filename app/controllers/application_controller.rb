class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :profile if Rails.env == "development"
  before_filter :authenticate

  private

  def profile
    Rack::MiniProfiler.authorize_request
  end

  include Auth

  helper_method :current_user, :active_user?
end
