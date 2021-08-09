# frozen_string_literal: true

# 小説のストーリーに関するクラス
class StoriesController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit destroy]
  before_action :find_novel, only: %i[new create edit update destroy]
  before_action :find_story, only: %i[edit update destroy]

  # ストーリーの投稿ページ
  def new
    # 投稿ページ用の空のStoryオブジェクトを作成
    @story = @novel.stories.build if user_signed_in?
  end

  # 投稿ボタンを押して、ストーリーを投稿する
  def create
    # ストロングパラメータを元に、オブジェクトを生成
    @story = @novel.stories.build(story_params)
    if @story.save
      flash[:success] = 'エピソードを公開しました'
      redirect_to current_user
    else
      render 'new'
    end
  end

  # ストーリーの編集ページ
  # アクションの前に、find_storyが実行される
  def edit; end

  # 更新ボタンを押して、ストーリーを更新
  # アクションの前に、find_storyが実行される
  def update
    if @story.update(story_params)
      flash[:success] = 'エピソードを編集しました'
      redirect_to @story.novel
    else
      render 'edit'
    end
  end

  # ストーリーを削除する
  # アクションの前に、find_storyが実行される
  def destroy
    @story.destroy
    flash[:success] = 'エピソードを1件削除しました'
    redirect_to root_url
  end

  # ストーリー閲覧ページ
  def show
    @novel = Novel.find_by(id: params[:novel_id])
    @story = Story.find(params[:id])
  end

  private

  # ストロングパラメータの登録
  def story_params
    params.require(:story).permit(:title, :text)
  end

  # お目当ての小説を特定する
  def find_novel
    @novel = current_user.novels.find_by(id: params[:novel_id])
    redirect_to root_url if @novel.nil?
  end

  # お目当てのストーリーを特定する
  def find_story
    @story = @novel.stories.find_by(id: params[:id])
    redirect_to root_url if @story.nil?
  end
end
