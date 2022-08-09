# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
puts 'Creating employees'
1.upto(5) do |i|
  print '.'
  Employee.where(email: "employee#{i}@test.com").first_or_create!(password: 'password', points: 0)
end
puts '✅'
puts 'Creating Admin account'
Employee.where(email: "gludekpl@gmail.com").first_or_create!(password: 'mypassword', points: 999) if Rails.env=='production'
Admin.where(email: "admin@test.com").first_or_create!(password: 'admintest')
puts '✅'
puts 'Creating Company values'
%w[Honesty Ownership Accountability Passion].each do |company_value_title|
  print '.'
  CompanyValue.where(title: company_value_title).first_or_create!
end
puts 'Creating Categories'
5.times { Category.where(title: Faker::Book.genre ).first_or_create! }
puts '✅'
puts 'Creating rewards'
1.upto(5) do |i|
  print '.'
  Reward.where(title: "Reward nr. #{i}").first_or_create!(description: Faker::TvShows::Supernatural.creature,
                                                          price: Faker::Number.within(range: 1..10),
                                                          categories: [Category.all.sample]
                                                        )
end
puts '✅'
puts 'Creating kudos'
1.upto(5) do |i|
  print '.'
  employee=Employee.find_by(email: "employee#{i}@test.com")
  Kudo.where(title: "Kudo nr. #{i}").first_or_create!(content: Faker::TvShows::Supernatural.creature,
                                                      giver: Employee.all.sample,
                                                      receiver: employee,
                                                      company_value: CompanyValue.all.sample)
  employee.increment(:points).save

end
puts '✅'
puts 'Creating orders'
1.upto(5) do |i|
  print '.'
  employee=Employee.find_by(email: "employee#{i}@test.com")
  Order.create(buyer: employee,
              reward: Reward.all.sample.to_json)
end
puts '✅'