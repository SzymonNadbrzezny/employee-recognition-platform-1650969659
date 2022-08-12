class Category < ApplicationRecord
  has_many :categories_rewards, dependent: :destroy
  has_many :rewards, through: :categories_rewards
  validates :title, presence: true
end
