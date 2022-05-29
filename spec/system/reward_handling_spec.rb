require 'rails_helper'

RSpec.describe 'Rewards handling allows' do
  let!(:employee) { create(:employee) }
  let!(:reward) { create(:reward) }

  before do
    sign_in employee
  end

  it 'Employee to read Rewards' do
    visit root_path

    click_link 'Rewards'

    expect(page).to have_content 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_content 'Show'

	click_link 'Show'
	expect(page).to have_content reward.title
	expect(page).to have_content reward.description
	expect(page).to have_content reward.price
  end
end
