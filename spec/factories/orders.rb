FactoryBot.define do
  factory :order do
    reward factory: :reward
    buyer factory: :employee
  end
end
