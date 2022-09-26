require 'faker'
FactoryBot.define do
  factory :employee do
    sequence(:email) { |i| "user#{i}@test.com" }
    password { 'password' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
