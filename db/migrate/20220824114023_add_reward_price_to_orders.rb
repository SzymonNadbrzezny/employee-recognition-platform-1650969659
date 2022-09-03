class AddRewardPriceToOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :reward, :string
    add_column :orders, :reward_price, :decimal
    add_reference :orders, :reward, null: false, foreign_key: { to_table: :rewards}
  end
end
