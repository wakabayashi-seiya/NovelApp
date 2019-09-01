# frozen_string_literal: true

class Novel < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :novel_tag_relations, dependent: :destroy
  has_many :tags, through: :novel_tag_relations
  has_many :stories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  mount_uploader :image, ImageUploader
  validates :title, presence: true
  validates :outline, presence: true
  validates :catchphrase, presence: true

  def self.search(search)
    return unless search

    where(['title LIKE ? OR keyword_one LIKE ? OR keyword_two LIKE ? OR keyword_three LIKE ? OR keyword_four LIKE ? OR keyword_five LIKE ?',
           "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end
