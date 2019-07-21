class NovelsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :correct_user_novel, only: [:edit, :update, :destroy]
  
  def new
    @novel = current_user.novels.build if logged_in?
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
  
  def search
  end
  
  def sf
    @genre = Genre.first
    @novels = @genre.novels.reverse_order
  end
  
  def dw
    @genre = Genre.find(2)
    @novels = @genre.novels.reverse_order
  end
  
  def cw
    @genre = Genre.find(3)
    @novels = @genre.novels.reverse_order
  end
  
  def love
    @genre = Genre.find(4)
    @novels = @genre.novels.reverse_order
  end
  
  def horror
    @genre = Genre.find(5)
    @novels = @genre.novels.reverse_order
  end
  
  def mystery
    @genre = Genre.find(6)
    @novels = @genre.novels.reverse_order
  end
  
  def suspense
    @genre = Genre.find(7)
    @novels = @genre.novels.reverse_order
  end
  
  def essay
    @genre = Genre.find(8)
    @novels = @genre.novels.reverse_order
  end
  
  def history
    @genre = Genre.find(9)
    @novels = @genre.novels.reverse_order
  end
  
  def complete
    @tag = Tag.find(1)
    @novels = @tag.novels.reverse_order
  end
  
  def incomplete
    @tag = Tag.find(2)
    @novels = @tag.novels.reverse_order
  end
  
    
  private
  
    def novel_params
      params.require(:novel).permit(:title, :catchphrase, :outline, :genre_id, :image, :user, :genre,
                                    :keyword_one, :keyword_two, :keyword_three, :keyword_four, :keyword_five,
                                    tag_ids: [])
    end
    
    def correct_user_novel
      @novel = current_user.novels.find_by(id: params[:id])
      redirect_to root_url if @novel.nil?
    end
  
  
end
