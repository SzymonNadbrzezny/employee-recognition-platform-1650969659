class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def number_of_avaible_kudos_greater_than_zero?
    errors.add(:number_of_avaible_kudos, "can't be below 0") if number_of_avaible_kudos.negative?
    number_of_avaible_kudos.positive?
  end

  def decrease_kudos(employee)
    avaible_kudos = (employee.number_of_avaible_kudos - 1)
    avaible_kudos = 0 if avaible_kudos.negative?
    Employee.update(employee.id, number_of_avaible_kudos: avaible_kudos)
  end
end
