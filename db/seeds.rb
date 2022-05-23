# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
1.upto(5) do |i|
  Employee.where(email: "employee#{i}@test.com").first_or_create!(password: 'password')
end
puts 'Admin account creation'
Admin.where(email: 'admin@test.com').first_or_create!(password: 'admintest')

puts 'Company values creation'
%w[Honesty Ownership Accountability Passion].each do |company_value_title|
  CompanyValue.where(title: company_value_title).first_or_create!
end
2.upto(5) do |i|
  Reward.where(title: "Reward nr. #{i}").first_or_create!(description: Faker::Creature::Animal,
                                                          price: Faker::Number.decimal(
                                                            l_digits: 3, r_digits: 3
                                                          ))
end
2.upto(5) do |i|
  Kudo.where(title: " Seeds for employee#{i}@test.com").first_or_create!(content: Faker::Creature::Animal,
                                                                         giver: Employee.all.sample,
                                                                         receiver: Employee.find_by(email: "employee#{i}@test.com"),
                                                                         company_value: CompanyValue.find_by(title: 'Honesty'))
end
