# frozen_string_literal: true

# お気に入り登録に関するクラス
# 自分以外のUserの小説のみ、お気に入りの登録・解除ができる
class FavoritesController < ApplicationController
  def create
    @novel = Novel.find(params[:novel_id])
    current_user.like(@novel)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @novel) }
      format.js
    end
  end

  def destroy
    @novel = Novel.find(params[:novel_id])
    current_user.unlike(@novel)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @novel) }
      format.js
    end
  end
end
