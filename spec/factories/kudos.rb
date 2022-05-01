FactoryBot.define do
  factory :kudo do
    title { 'Kudo-test' }
    content { 'Don\'t mind me, just testing!' }

    receiver factory: :employee
    giver factory: :employee
  end
end
