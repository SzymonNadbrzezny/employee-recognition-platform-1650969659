# == Schema Information
#
# Table name: employees
#
#  id                      :bigint           not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  number_of_avaible_kudos :integer          default(10), not null
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#
class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :kudos, foreign_key: 'receiver_id', dependent: :destroy, inverse_of: :receiver
  has_many :kudos, foreign_key: 'giver_id', dependent: :destroy, inverse_of: :giver

  def decrease_kudos(employee)
    avaible_kudos = (employee.number_of_avaible_kudos - 1)
    avaible_kudos = 0 if avaible_kudos.negative?
    Employee.update(employee.id, number_of_avaible_kudos: avaible_kudos)
  end
end
