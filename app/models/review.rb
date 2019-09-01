# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :novel
  belongs_to :user
  validates :title, presence: true
  validates :text, presence: true
  default_scope -> { order(created_at: :desc) }
end
