# frozen_string_literal: true

# 小説のレビューに関するクラス
class ReviewsController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit destroy]
  before_action :find_novel, only: %i[new create]
  before_action :find_review, only: %i[edit update destroy]

  # レビューの投稿ページ
  def new
    # 投稿ページ用の空のレビューオブジェクトを作成
    @review = @novel.reviews.build if user_signed_in?
  end

  def create
    # フォームからのパラメータを元に、オブジェクトを作成
    @review = @novel.reviews.build(review_params)

    # Reviewテーブルにinsert文を発行
    # 成功した場合、reviewをした小説の詳細ページへ遷移する
    if @review.save
      flash[:success] = 'レビューを投稿しました'
      redirect_to @review.novel
    
    # 失敗した場合、投稿ページへ戻る
    else
      render 'new'
    end
  end
  
  # レビューの編集ページ
  # アクションの前に、find_reviewを実行する
  def edit; end

  # 更新ボタンを押して、レビューを更新する
  # アクションの前に、find_reviewを実行する
  def update
    if @review.update(review_params)
      flash[:success] = 'レビューを編集しました'
      redirect_to @review.novel
    else
      render 'edit'
    end
  end

  def show; end

  # レビューを削除する
  def destroy
    @review.destroy
    flash[:success] = 'レビューを1件削除しました'
    redirect_to root_url
  end

  private

  # ストロングパラメータの登録
  def review_params
    params.require(:review).permit(:title, :text, :user_id)
  end

  # 小説を特定する
  def find_novel
    @novel = Novel.find_by(id: params[:novel_id])
  end

  # レビューを特定する
  def find_review
    @review = current_user.reviews.find_by(id: params[:id])
    redirect_to root_url if @review.nil?
  end
end
