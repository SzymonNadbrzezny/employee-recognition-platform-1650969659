# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.upto(5) do |i|
  Employee.where(email: "employee#{i}@test.com").first_or_create!(password: 'password')
end
puts 'Admin account creation'
Admin.where(email: 'admin@test.com').first_or_create!(password: 'admintest')

puts 'Company values creation'
CompanyValue.where(title: 'Honesty').first_or_create!
CompanyValue.where(title: 'Ownership').first_or_create!
CompanyValue.where(title: 'Accountability').first_or_create!
CompanyValue.where(title: 'Passion').first_or_create!
2.upto(5) do |i|
  Kudo.where(title: " Seeds for employee#{i}@test.com").first_or_create!(content: 'smh',
                                                                         giver: Employee.all.sample,
                                                                         receiver: Employee.find_by(email: "employee#{i}@test.com"),
                                                                         company_value: CompanyValue.find_by(title: 'Honesty'))
end
