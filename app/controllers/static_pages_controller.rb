# frozen_string_literal: true

class StaticPagesController < ApplicationController
  after_action :read, only: [:box]

  # ホーム画面
  def home
    # 最新投稿された小説を3件取得する
    @novels = Novel.limit(3).order('created_at DESC')

    # お気に入りに登録された数が多い上位5件を取得する
    @ranking = Novel.find(Favorite.group(:novel_id).order('count(novel_id) desc').limit(5).pluck(:novel_id))
  end

  # ヘルプページ
  def help; end

  # 小説投稿アプリに関する説明をするページ
  def about; end

  # お気に入りに登録した小説の更新情報をお知らせするページ
  # 毎アクション後に、readメソッドを実行して、次回再びアクセスしたときに、今回の更新分は表示されないようにする
  def box
    @user = current_user
    @favorites = @user.favorites.all
  end

  # 小説の検索をするページ
  def search; end

  private

  # 更新情報のお知らせページにアクセスした時間を自分のUserレコードに保存する
  def read
    return unless user_signed_in?

    @user = current_user
    @user.lastaccesstime = DateTime.now
    @user.save!
  end
end
