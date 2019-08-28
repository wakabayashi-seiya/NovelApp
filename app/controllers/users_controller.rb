class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @notes = @user.notes.paginate(page: params[:page])
    @novels = @user.novels.reverse_order.paginate(page: params[:page])
    @favorites = @user.favnovels.reverse_order.paginate(page: params[:page])
    @reviews = @user.reviews.paginate(page: params[:page])
  end
  
  
  # private
  
  #   def user_params
  #     params.require(:user).permit(:name, :email, :password, :password_confirmation,
  #                                 :field, :introduction)
  #   end
    
end
