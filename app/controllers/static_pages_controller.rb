class StaticPagesController < ApplicationController
  def home
    @novels = Novel.limit(3).order("created_at DESC")
    # @ranking = Novel.limit(5).order()
  end

  def help
  end
  
  def about
  end
  
end
