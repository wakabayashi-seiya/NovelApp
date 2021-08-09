# frozen_string_literal: true

# 小説をジャンルごとに表示する用のクラス
# 投稿が最新なもの順に表示される
class GenreNovelsController < ApplicationController

  # SF
  def sf
    @genre = Genre.first
    @novels = @genre.novels.reverse_order
  end

  # 異世界ファンタジー
  def dw
    @genre = Genre.find(2)
    @novels = @genre.novels.reverse_order
  end

  # 現代ファンタジー
  def cw
    @genre = Genre.find(3)
    @novels = @genre.novels.reverse_order
  end

  # 恋愛
  def love
    @genre = Genre.find(4)
    @novels = @genre.novels.reverse_order
  end

  # ホラー
  def horror
    @genre = Genre.find(5)
    @novels = @genre.novels.reverse_order
  end

  # ミステリー
  def mystery
    @genre = Genre.find(6)
    @novels = @genre.novels.reverse_order
  end

  # サスペンス
  def suspense
    @genre = Genre.find(7)
    @novels = @genre.novels.reverse_order
  end

  # エッセイ
  def essay
    @genre = Genre.find(8)
    @novels = @genre.novels.reverse_order
  end

  # 歴史
  def history
    @genre = Genre.find(9)
    @novels = @genre.novels.reverse_order
  end
end
