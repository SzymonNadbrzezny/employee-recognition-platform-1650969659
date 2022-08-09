class Category < ApplicationRecord
  has_many :categorized_rewards, dependent: :destroy
  has_many :rewards, through: :categorized_rewards
end
