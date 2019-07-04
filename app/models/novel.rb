class Novel < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :novel_tag_relations, dependent: :destroy
  has_many :tags, through: :novel_tag_relations
  has_many :stories
  has_many :reviews
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :outline, presence: true
  validates :catchphrase, presence: true
end
