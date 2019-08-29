class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :field, :introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :field, :introduction])
  end
  
  private
    
    def logged_in_user
      unless user_signed_in?
        flash[:danger] = "ログインしてください"
        redirect_to root_url
      end
    end
end
