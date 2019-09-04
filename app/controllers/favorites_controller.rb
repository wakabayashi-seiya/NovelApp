# frozen_string_literal: true

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
