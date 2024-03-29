# frozen_string_literal: true

class UsersController < ApplicationController
  # Userの詳細情報を取得する
  def show
    @user = User.find(params[:id])
    @notes = @user.notes.paginate(page: params[:page])
    @novels = @user.novels.reverse_order.paginate(page: params[:page])
    @favorites = @user.favnovels.reverse_order.paginate(page: params[:page])
    @reviews = @user.reviews.paginate(page: params[:page])
  end
end
