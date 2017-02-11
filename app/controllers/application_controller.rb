class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :email, :password, :password_confirmation, :role
    ])
  end

  def ensure_support_agent!
    if !current_user.try(:support_agent?)
      flash[:alert] = 'Only support agents are allowed to access that page!'
      redirect_to root_path
    end
  end
end
