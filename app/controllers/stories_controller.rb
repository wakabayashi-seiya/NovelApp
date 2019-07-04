class StoriesController < ApplicationController
  before_action :current_novel, only: [:new, :create, :edit, :update, :destroy]
  before_action :current_novel_story, only: [:edit, :update, :destroy]
  
  def new
    @story = @novel.stories.build if logged_in?
  end
  
  def create
    @story = @novel.stories.build(story_params)
    if @story.save
      flash[:success] = "エピソードを公開しました"
      redirect_to current_user
    else
      render 'new'
    end
  end
  
  def edit
  end
    
  def update
    if @story.update_attributes(story_params)
      flash[:success] = "エピソードを編集しました"
      redirect_to @story.novel
    else
      render 'edit'
    end
  end 
  
  def destroy
    @story.destroy
    flash[:success] = "エピソードを1件削除しました"
    redirect_to root_url
  end
  
  def show
    @novel = Novel.find_by(id: params[:novel_id])
    @story = Story.find(params[:id])
  end
  
  
  private
  
    def story_params
      params.require(:story).permit(:title, :text)
    end
    
    def current_novel
      @novel = current_user.novels.find_by(id: params[:novel_id])
      redirect_to root_url if @novel.nil?
    end
    
    def current_novel_story
      @story = @novel.stories.find_by(id: params[:id])
      redirect_to root_url if @story.nil?
    end
    
end
