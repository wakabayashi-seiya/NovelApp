# frozen_string_literal: true

class CompleteImcompleteNovelsController < ApplicationController
  def complete
    @tag = Tag.find(1)
    @novels = @tag.novels.reverse_order
  end

  def incomplete
    @tag = Tag.find(2)
    @novels = @tag.novels.reverse_order
  end
end
