class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You do not have permission to do that!"
    redirect_to error_path
  end

  private

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if (cookies[:auth_token])
  end
  helper_method :current_user

  def authorize
    redirect_to login_path, :notice => "Please login to continue." if current_user.nil?
  end
end
