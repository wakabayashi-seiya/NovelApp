class AccountActivationsController < ApplicationController
  
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "本登録が完了しました。ようこそ、ビブリオテックへ！"
      redirect_to user
    else
      flash[:danger] = "アカウント有効化に失敗しました。もう一度、会員登録の手続きをお願いします。"
      redirect_to root_url
    end
  end
  
end
