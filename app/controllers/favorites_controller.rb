class FavoritesController < ApplicationController
  def create
    @novel = Novel.find(params[:novel_id])
    current_user.like(@novel)
    redirect_back(fallback_location: root_path) 
    # respond_to do |format|
    #   format.html { redirect_back(fallback_location: root_path) } 
    #   format.js
    # end
  end

  def destroy
    @novel = Novel.find(params[:novel_id])
    current_user.unlike(@novel)
    redirect_back(fallback_location: root_path) 
    # respond_to do |format|
    #   format.html { redirect_back(fallback_location: root_path) }
    #   format.js
    # end
  end
end
