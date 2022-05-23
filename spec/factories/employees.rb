# == Schema Information
#
# Table name: employees
#
#  id                        :bigint           not null, primary key
#  email                     :string           default(""), not null
#  encrypted_password        :string           default(""), not null
#  number_of_available_kudos :integer          default(10), not null
#  remember_created_at       :datetime
#  reset_password_sent_at    :datetime
#  reset_password_token      :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :employee do
    sequence(:email) { |i| "user#{i}@test.com" }
    password { 'password' }
  end
end
