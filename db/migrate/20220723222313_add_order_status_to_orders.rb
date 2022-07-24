class AddOrderStatusToOrders < ActiveRecord::Migration[6.1]
  def up
    add_column :orders, :status, :integer, default: 0, null: false
    add_index :orders, :status
  end

  def down
    remove_column :orders, :status
  end
end
