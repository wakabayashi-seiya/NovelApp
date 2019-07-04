class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to root_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user == @user
    end
    
end
