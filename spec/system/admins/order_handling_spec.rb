require 'rails_helper'

RSpec.describe 'Orders handling allows' do
  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee, points: 10) }
  let!(:reward) { create(:reward, price: 2) }
  let!(:order) { create(:order, buyer: employee, reward: reward.to_json) }

  before do
    sign_in admin
  end

  it 'Admin to list Orders created by Employees and see price of reward at time of purchase' do
    visit admins_employees_path
    click_link 'Orders'
    expect(page).to have_content reward.price.to_s
    expect(page).to have_content employee.email
  end
end
