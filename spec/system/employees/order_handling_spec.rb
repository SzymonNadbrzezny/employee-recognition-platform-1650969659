require 'rails_helper'
require 'faker'

RSpec.describe 'Orders handling allows' do
  let!(:employee) { create(:employee, points: 10) }
  let!(:reward) { create(:reward, price: 2) }
  let!(:order) { create(:order, buyer: employee, reward: reward) }
  let!(:delivered_order) { create(:order, buyer: employee, reward: reward, status: :delivered) }

  before do
    sign_in employee
  end

  it 'Employee to create Orders' do
    visit rewards_path

    expect(page).to have_content 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_content 'Buy'

    click_link 'Buy'
    expect(page).to have_content 'New Order'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_button 'Create Order'
    click_button 'Create Order'
    expect(page).to have_content("Current points #{10 - reward.price}")
  end

  it 'Employee to create orders for rewards with delivery by post' do
    reward.post!
    street = Faker::Address.street_address
    city = Faker::Address.city
    postal_code = Faker::Address.zip_code

    visit rewards_path

    expect(page).to have_content 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_content 'Buy'

    click_link 'Buy'
    expect(page).to have_content 'New Order'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_content 'Street'
    expect(page).to have_content 'Postal code'
    expect(page).to have_content 'City'
    expect(page).to have_button 'Create Order'

    fill_in 'order_form_city', with: city
    fill_in 'order_form_street', with: street
    fill_in 'order_form_postal_code', with: postal_code

    click_button 'Create Order'
    expect(page).to have_content("Current points #{employee.points - reward.price}")
    expect(page).to have_content('Order was successfully created.')
  end

  it 'Employee to list their Orders and see price of reward at time of purchase' do
    order_price = reward.price
    reward.price = 5
    visit root_path
    click_link 'Orders'
    expect(page).to have_content order_price.to_s
    expect(page).to have_no_content reward.price.to_s
  end

  it 'Employee to filter orders by their status' do
    visit orders_employee_path(employee.id)
    expect(page).to have_link 'Delivered'
    expect(page).to have_link 'All'
    expect(page).to have_link 'Awaiting Delivery'
    expect(page).to have_content "#{order.id} #{reward.title}"
    expect(page).to have_content "#{delivered_order.id} #{reward.title}"
    click_link 'Delivered'
    expect(page).to have_no_content "#{order.id} #{reward.title}"
    expect(page).to have_content "#{delivered_order.id} #{reward.title}"
    click_link 'Awaiting Delivery'
    expect(page).to have_content "#{order.id} #{reward.title}"
    expect(page).to have_no_content "#{delivered_order.id} #{reward.title}"
    click_link 'All'
    expect(page).to have_content "#{order.id} #{reward.title}"
    expect(page).to have_content "#{delivered_order.id} #{reward.title}"
  end
end
