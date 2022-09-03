FactoryBot.define do
  factory :order do
    reward factory: :reward
    buyer factory: :employee
    reward_price { reward.price }
  end
end
