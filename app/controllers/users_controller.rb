class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destory]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "メールを送信しました。確認してください。"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を変更しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
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
    @novels = @user.novels.paginate(page: params[:page])
  end
  
  def likes
    @user = User.find(params[:id])
    @favorites = @user.favnovels.paginate(page: params[:page])
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
