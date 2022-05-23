require 'faker'
# == Schema Information
#
# Table name: rewards
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  price       :decimal(, )      not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| "Reward nr. #{i}" }
    description { Faker::TvShows::Supernatural.creature }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
