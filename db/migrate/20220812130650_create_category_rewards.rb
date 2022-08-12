class CreateCategoryRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :categories_rewards, id: false  do |t|
        t.belongs_to :reward
        t.belongs_to :category
    end
    add_index(:categories_rewards, [:category_id, :reward_id], unique: true)
  end
end
