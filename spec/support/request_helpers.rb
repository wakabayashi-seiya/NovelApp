module RequestHelpers
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  def user_signed_in?
    !((controller.current_user).nil?)
  end
end