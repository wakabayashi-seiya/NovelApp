# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Deviseでは、メールアドレスとパスワードのみをストロングパラメータとして登録している
  # それ以外のパラメータをここで登録する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name field introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name field introduction])
  end

  # Rubyでは、子クラスから親クラスのprivateメソッドを呼び出せる
  private

  # Userがログインしているか確認する
  # このクラスを継承しているクラスで使う
  def logged_in_user

    # ログインしている場合
    # user_signed_in?はdeviseのヘルパーメソッドで、Userがログイン済みかを判定する
    return if user_signed_in?

    # ログインしていない場合、ホーム画面に戻る
    flash[:danger] = 'ログインしてください'
    redirect_to root_url
  end
end
