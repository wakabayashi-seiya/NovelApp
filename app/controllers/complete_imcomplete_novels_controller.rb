# frozen_string_literal: true

# 進捗状況を選択するクラス
class CompleteImcompleteNovelsController < ApplicationController

  # 進捗状況を「完結」にする 
  def complete
    @tag = Tag.find(1)
    @novels = @tag.novels.reverse_order
  end

  # 進捗状況を「連載中」にする
  def incomplete
    @tag = Tag.find(2)
    @novels = @tag.novels.reverse_order
  end
end
