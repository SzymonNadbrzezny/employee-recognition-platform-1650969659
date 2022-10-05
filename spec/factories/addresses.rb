require 'faker'
FactoryBot.define do
  factory :address do
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    postal_code { Faker::Address.zip_code }
    employee { nil }
    last_used { Time.current }
  end
end
