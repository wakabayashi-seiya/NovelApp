class NovelsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :find_novel, only: [:edit, :update, :destroy]
  
  def new
    @novel = current_user.novels.build if user_signed_in?
  end
  
  def create
    @novel = current_user.novels.build(novel_params)
    if @novel.save
      flash[:success] = "小説を作成しました"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @novel.update_attributes(novel_params)
      flash[:success] = "基本情報を編集しました"
      redirect_to @novel
    else
      render 'edit'
    end
  end 
  
  def destroy
    @novel.destroy
    flash[:success] = "作品を1件削除しました"
    redirect_to root_url
  end
    
  def show
    @novel = Novel.find(params[:id])
    @novels = @novel.user.novels.all
    @stories = @novel.stories.paginate(page: params[:page])
    @reviews = @novel.reviews.all
    @favorites = @novel.favorites.all
  end
  
  def index
    @novels = Novel.paginate(page: params[:page]).search(params[:search])
  end
  
  private
  
    def novel_params
      params.require(:novel).permit(:title, :catchphrase, :outline, :genre_id, :image, :user, :genre,
                                    :keyword_one, :keyword_two, :keyword_three, :keyword_four, :keyword_five,
                                    tag_ids: [])
    end
    
    def find_novel
      @novel = current_user.novels.find_by(id: params[:id])
      redirect_to root_url if @novel.nil?
    end
end
