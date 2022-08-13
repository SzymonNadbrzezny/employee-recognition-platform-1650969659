require 'faker'
FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| "Reward nr. #{i}" }
    description { Faker::TvShows::Supernatural.creature }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 1) }

    categories { build_list(:category, 1) }
  end
end
