class Review < ApplicationRecord
  belongs_to :novel
  belongs_to :user
end
