class Tag < ApplicationRecord
  has_many :novel_tag_relations, dependent: :destroy
  has_many :novels, through: :novel_tag_relations
end
