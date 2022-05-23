# == Schema Information
#
# Table name: kudos
#
#  id               :bigint           not null, primary key
#  content          :text             not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_value_id :bigint           not null
#  giver_id         :bigint           not null
#  receiver_id      :bigint           not null
#
# Indexes
#
#  index_kudos_on_company_value_id  (company_value_id)
#  index_kudos_on_giver_id          (giver_id)
#  index_kudos_on_receiver_id       (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_value_id => company_values.id)
#  fk_rails_...  (giver_id => employees.id)
#  fk_rails_...  (receiver_id => employees.id)
#
FactoryBot.define do
  factory :kudo do
    title { 'Kudo-test' }
    content { 'Don\'t mind me, just testing!' }

    company_value
    receiver factory: :employee
    giver factory: :employee
  end
end
