class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  


  protected

  def after_update_path_for(resource)
    account_path
  end

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :date_of_birth])
  end
end
