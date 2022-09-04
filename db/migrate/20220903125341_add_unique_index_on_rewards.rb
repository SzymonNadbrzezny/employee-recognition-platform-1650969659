class AddUniqueIndexOnRewards < ActiveRecord::Migration[6.1]
  def change
    add_index(:rewards, :title, unique: true, name: 'unique_reward_titles')
  end
end
