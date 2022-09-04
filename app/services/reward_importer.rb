class RewardImporter < ApplicationService
  attr_reader :rewards

  # rubocop:disable Lint/MissingSuper
  def initialize(rewards)
    @rewards = rewards
  end
  # rubocop:enable Lint/MissingSuper

  def call
    Reward.transaction do
      rewards.each do |reward_values|
        reward = Reward.find_or_initialize_by(title: reward_values[:title])
        reward.price = reward_values[:price]
        reward.description = reward_values[:description]
        reward.categories = [Category.find_by(title: reward_values[:category])]
        reward.save!
      end
    end
  end
end
