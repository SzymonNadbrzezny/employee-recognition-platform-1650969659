class AddOrderStatusToOrders < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE order_status AS ENUM (
        'awaiting_delivery', 'delivered'
      );
    SQL

    add_column :orders, :status, :order_status, default: "awaiting_delivery", null: false
    add_index :orders, :status
  end

  def down
    remove_column :orders, :status

    execute <<-SQL
      DROP TYPE order_status;
    SQL
  end
end
