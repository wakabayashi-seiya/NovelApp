class StaticPagesController < ApplicationController
  after_action :read, only: [:box]
  
  def home
    @novels = Novel.limit(3).order("created_at DESC")
    @ranking = Novel.find(Favorite.group(:novel_id).order('count(novel_id) desc').limit(5).pluck(:novel_id))
  end

  def help
  end
  
  def about
  end
  
  def box
    @user = current_user
    @favorites = @user.favorites.all
  end
  
  private
    
    def read
      if user_signed_in?
        @user = current_user
        @user.lastaccesstime = DateTime.now
        @user.save!
      end
    end
  
end
