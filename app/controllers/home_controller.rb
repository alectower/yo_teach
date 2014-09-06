class HomeController < ApplicationController
  skip_filter :authenticate
  layout 'home'

  def landing
    redirect_to calendar_path if active_user?
  end
end
