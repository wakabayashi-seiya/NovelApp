class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :destory]
  before_action :correct_user, only: [:destroy]
  
 
  def show
    @user = User.find(params[:id])
  end
  
  def index
  
  end
  
  def set
    @user = User.find_by(id: current_user.id)
  end
  
  def recent
    @user = User.find(params[:id])
    @notes = @user.notes.paginate(page: params[:page])
  end
  
  def colection
    @user = User.find(params[:id])
    @novels = @user.novels.reverse_order.paginate(page: params[:page])
  end
  
  def likes
    @user = User.find(params[:id])
    @favorites = @user.favnovels.reverse_order.paginate(page: params[:page])
  end
  
  def comment
    @user = User.find(params[:id])
    @reviews = @user.reviews.paginate(page: params[:page])
  end
  
  def destroy
    @user.destroy
    flash[:success] = "ユーザーを消去しました"
    redirect_to root_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   :field, :introduction)
    end
    
    
    
  
end
