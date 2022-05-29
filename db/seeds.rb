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
  Employee.where(email: "employee#{i}@test.com").first_or_create!(password: 'password')
end
puts '✅'
puts 'Creating Admin account'
Admin.where(email: 'admin@test.com').first_or_create!(password: 'admintest')
puts '✅'
puts 'Creating Company values'
%w[Honesty Ownership Accountability Passion].each do |company_value_title|
  print '.'
  CompanyValue.where(title: company_value_title).first_or_create!
end
puts '✅'
puts 'Creating rewards'
1.upto(5) do |i|
  print '.'
  Reward.where(title: "Reward nr. #{i}").first_or_create!(description: Faker::TvShows::Supernatural.creature,
                                                          price: Faker::Number.decimal(
                                                            l_digits: 3, r_digits: 2
                                                          ))
end
puts '✅'
puts 'Creating kudos'
1.upto(5) do |i|
  print '.'
  Kudo.where(title: "Kudo nr. #{i}").first_or_create!(content: Faker::TvShows::Supernatural.creature,
                                                      giver: Employee.all.sample,
                                                      receiver: Employee.find_by(email: "employee#{i}@test.com"),
                                                      company_value: CompanyValue.find_by(title: 'Honesty'))
end
puts '✅'
