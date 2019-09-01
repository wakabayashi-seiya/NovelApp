# frozen_string_literal: true

class GenreNovelsController < ApplicationController
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
end
