class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def guest_user
    Guest.where(token: guest_token).first_or_create
  end

  private
  
  def guest_token
    session[:guest_token] ||= SecureRandom.uuid
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)}
  end



end
