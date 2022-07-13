FactoryBot.define do
  factory :admin do
    sequence(:email) { |i| "admin#{i}@test.com" }
    password { 'admintest' }
  end
end
