# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit destroy]
  before_action :find_novel, only: %i[new create]
  before_action :find_review, only: %i[edit update destroy]

  def new
    @review = @novel.reviews.build if user_signed_in?
  end

  def create
    @review = @novel.reviews.build(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました'
      redirect_to @review.novel
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      flash[:success] = 'レビューを編集しました'
      redirect_to @review.novel
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @review.destroy
    flash[:success] = 'レビューを1件削除しました'
    redirect_to root_url
  end

  private

  def review_params
    params.require(:review).permit(:title, :text, :user_id)
  end

  def find_novel
    @novel = Novel.find_by(id: params[:novel_id])
  end

  def find_review
    @review = current_user.reviews.find_by(id: params[:id])
    redirect_to root_url if @review.nil?
  end
end
