FactoryBot.define do
  factory :company_value do
    sequence(:title) { |i| "Company Value #{i}" }
  end
end
