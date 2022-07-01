class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.text 'reward', null: false
      t.references :buyer, null: false, foreign_key: { to_table: :employees}
      t.timestamps
    end
  end
end
