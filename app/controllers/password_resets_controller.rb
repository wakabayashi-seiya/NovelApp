class PasswordResetsController < ApplicationController
  before_action :create_instance_of_user, only: [:edit, :update]
  before_action :validate_user, only: [:edit, :update]
  before_action :validate_expiration, only: [:edit, :update]
  
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:success] = "パスワードリセットメールを送信しました。ご確認ください。"
      redirect_to root_url
    else
      flash.now[:danger] = "指定されたメールアドレスが見つかりません。ご確認ください。"
      redirect_to root_url
    end
  end
  
  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "Password cannot be empty.")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "パスワードを変更しました。"
      redirect_to @user 
    else
      render 'edit'
    end
  end
  
  private
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    def create_instance_of_user
       @user = User.find_by(email: params[:email])
    end
    
    def validate_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    def validate_expiration
      if @user.password_reset_expired?
        message = "パスワード再設定の有効期限が切れました。"
        message += "最初から、変更手続きをやり直してください。"
        flash[:danger] = message
        redirect_to new_password_reset_path
      end
    end
end
