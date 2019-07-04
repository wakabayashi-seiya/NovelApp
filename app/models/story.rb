class Story < ApplicationRecord
  belongs_to :novel
  validates :title, presence: true
  validates :text, presence: true
end
