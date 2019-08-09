class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return unless has_signed_in?

    @current_user ||= User.find_or_create_by(ip: request.remote_ip.to_s)
  end

  def has_signed_in?
    session[:intro_admin_authenticated] == Intro.config.admin_username_digest
  end
end
