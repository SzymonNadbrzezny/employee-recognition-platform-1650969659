class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title

      t.timestamps
    end
    create_table :categorized_rewards, id: false do |t|
      t.belongs_to :reward
      t.belongs_to :category
    end
  end
end
