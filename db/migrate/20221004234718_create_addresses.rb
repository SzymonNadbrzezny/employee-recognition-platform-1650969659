class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :city, null: false
      t.string :postal_code, null: false
      t.references :employee, null: false, foreign_key: { to_table: :employees }
      t.datetime :last_used

      t.timestamps
    end
  end
end
