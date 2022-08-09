class CategorizedReward < ApplicationRecord
  belongs_to :reward
  belongs_to :category
end
