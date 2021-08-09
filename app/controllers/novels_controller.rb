# frozen_string_literal: true

class NovelsController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit destroy]
  before_action :find_novel, only: %i[edit update destroy]

  # 小説の投稿ページ
  def new
    # buildで投稿ページ用の、空のオブジェクトの生成をする
    # current_userは、deviseの機能で、現在ログインしているオブジェクトを示す
    # 現在ログインしているUserの空のNovelオブジェクトを生成する
    @novel = current_user.novels.build if user_signed_in?
  end

  # 投稿ボタンを押して、小説を投稿する
  def create
    # ストロングパラメータを渡したNovelのインスタンスを生成する
    @novel = current_user.novels.build(novel_params)

    # saveでNovelテーブルにinsertを発行する
    # 上記のNovelオブジェクトを用いる
    if @novel.save
      flash[:success] = '小説を作成しました'
      redirect_to root_url

    # 正常に保存されなかった場合、作成ページに遷移する
    else
      render 'new'
    end
  end

  # 小説の編集ページ
  # アクションを実行する前に、find_novelで小説を特定する
  def edit; end

  # 更新ボタンを押して、小説を更新する
  # アクションを実行する前に、find_novelで小説を特定する
  def update

    # Novelテーブルにupdateを発行する
    if @novel.update(novel_params)
      flash[:success] = '基本情報を編集しました'

      # 小説の詳細ページへ遷移する
      redirect_to @novel

    # 更新に失敗した場合、更新ページに戻る
    else
      render 'edit'
    end
  end

  # 小説を削除する
  # アクションを実行する前に、find_novelで小説を特定する
  def destroy
    @novel.destroy
    flash[:success] = '作品を1件削除しました'
    redirect_to root_url
  end

  # 小説の詳細ページ
  def show
    # 特定した小説を取得
    @novel = Novel.find(params[:id])

    # 特定した小説を書いたUserの小説全部を取得
    @novels = @novel.user.novels.all

    # 小説の各ストーリーを取得
    @stories = @novel.stories.paginate(page: params[:page])

    # 小説のレビューを取得
    @reviews = @novel.reviews.paginate(page: params[:page])

    # 小説のお気に入り登録を取得
    @favorites = @novel.favorites.all
  end
  
  # 小説を検索する
  def index
    @novels = Novel.paginate(page: params[:page]).search(params[:search])
  end

  private

  # ストロングパラメータの登録
  def novel_params
    params.require(:novel).permit(:title, :catchphrase, :outline, :genre_id, :image, :user, :genre,
                                  :keyword_one, :keyword_two, :keyword_three, :keyword_four, :keyword_five,
                                  tag_ids: [])
  end

  # 小説を特定する
  def find_novel
    @novel = current_user.novels.find_by(id: params[:id])

    # もし小説を特定できなかった場合、Homeに遷移する
    redirect_to root_url if @novel.nil?
  end
end
