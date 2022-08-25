require 'rails_helper'

RSpec.describe 'Orders handling allows' do
  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee, points: 10) }
  let!(:reward) { create(:reward, price: 2) }
  let!(:order) { create(:order, buyer: employee, reward: reward) }

  before do
    sign_in admin
  end

  it 'Admin to list Orders created by Employees and see price of reward at time of purchase' do
    visit admins_employee_path(employee.id)

    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price.to_s
    expect(page).to have_content employee.email
  end

  it 'Admin to deliver orders' do
    visit admins_employee_path(employee.id)

    expect(page).to have_content reward.title
    expect(page).to have_link 'Deliver', href: admins_order_path(order.id)
    click_link 'Deliver'
    expect(page).to have_content 'Order was successfully updated.'
    expect(page).to have_content 'Delivered'
    expect(page).to have_no_link 'Deliver'
  end

  it 'Admin to export all orders to csv file' do
    visit admins_root_path
    expect(page).to have_link 'Export orders'
    click_link 'Export orders'
    Order.attribute_names.each do |attribute|
      expect(page).to have_content attribute.upcase
      expect(page).to have_content order[attribute]
    end 
  end
end
