class Reward < ApplicationRecord
  paginates_per 3
  has_many :categorized_rewards, dependent: :destroy
  has_many :categories, through: :categorized_rewards
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :categories, presence: true

  def self.from_json(reward_json)
    reward_from_json = JSON.parse(reward_json)
    reward = Reward.new
    reward.attribute_names.each { |attribute| reward[attribute] = reward_from_json[attribute] }
    reward
  end
end
