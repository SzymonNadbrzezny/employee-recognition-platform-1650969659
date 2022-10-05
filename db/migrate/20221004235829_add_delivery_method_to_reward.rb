class AddDeliveryMethodToReward < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :delivery_method, :string, null: false
  end
end
