# frozen_string_literal: true

class NovelTagRelation < ApplicationRecord
  belongs_to :novel
  belongs_to :tag
end
