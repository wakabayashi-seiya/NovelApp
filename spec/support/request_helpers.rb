module RequestHelpers
  
  def user_signed_in?
    !((controller.current_user).nil?)
  end
end
