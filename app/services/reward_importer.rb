class RewardImporter < ApplicationService
  attr_reader :rewards

  # rubocop:disable Lint/MissingSuper
  def initialize(rewards_file)
    @result = { success?: nil, failure: Hash.new(error: '', row: nil) }
    rewards = array_of_reward_hashes(CSV.parse(rewards_file.read, col_sep: ','))
    rewards_file.close
    @rewards = rewards
  end
  # rubocop:enable Lint/MissingSuper

  def call
    begin
      Reward.transaction do
        rewards.each_with_index do |reward_values, i|
          reward = Reward.find_or_initialize_by(title: reward_values[:title])
          reward.price = reward_values[:price]
          reward.description = reward_values[:description]
          category = Category.find_by(title: reward_values[:category])
          unless category
            result[:success?] = false
            result[:failure][:error] = "Category with this title doesn't exit"
            result[:failure][:row] = i
            raise ActiveRecord::Rollback
          end
          reward.categories = [category]
          reward.save!
        end

        result[:success?] = true
        result[:value!] = { count: rewards.length, imported_reward_titles: rewards.pluck(:title) }
      end
    rescue ActiveRecord::RecordNotSaved
      result[:success?] = false
      result[:failure][:error] = 'Unknown problem'
      result[:failure][:row] = 0
    end
    self
  end

  private

  def array_of_reward_hashes(rewards_array)
    rewards = rewards_array.map { |r| r.map!(&:strip) }
    headers = rewards.shift.map(&:to_sym)
    rewards.map! { |row| row.map.with_index { |v, i| [headers[i], v] }.to_h }
  end
end
