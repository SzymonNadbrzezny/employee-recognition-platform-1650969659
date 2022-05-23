class RenameNumberOfAvaibleKudosfromEmployees < ActiveRecord::Migration[6.1]
  def change
    rename_column :employees, :number_of_avaible_kudos, :number_of_available_kudos
  end
end
