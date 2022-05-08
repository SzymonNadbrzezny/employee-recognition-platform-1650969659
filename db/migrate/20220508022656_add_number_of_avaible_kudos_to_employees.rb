class AddNumberOfAvaibleKudosToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :number_of_avaible_kudos, :integer, null: false, default: 10
  end
end
