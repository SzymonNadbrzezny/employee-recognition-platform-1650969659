require 'rails_helper'

RSpec.describe 'Orders handling allows' do
  let!(:employee) { create(:employee, points: 10) }
  let!(:reward) { create(:reward, price: 2) }

  before do
    sign_in employee
  end

  it 'Employee to create Orders' do
    visit rewards_path

    expect(page).to have_content 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_content 'Buy'

    visit rewards_path

    click_link 'Buy'
    expect(page).to have_content 'New Order'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_button 'Create Order'
    click_button 'Create Order'

    expect(page).to have_content("Current points #{10 - reward.price}")
  end
end
