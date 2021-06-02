class ApplicationController < ActionController::Base
  include Pundit
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  
  

  protected
  def configure_permitted_parameters
    added_attrs = [:name, :phone_number, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    if resource.user?
      employee_requests_path
    elsif resource.admin?
      admin_requests_path
    elsif resource.manager?
      manager_delivers_path
    else
      new_user_session_path
    end
  end

  def user_not_authorized
  flash[:error] = "You are not authorized to perform this action."
    # redirect_to(request.referrer || root_path)
  end
end
