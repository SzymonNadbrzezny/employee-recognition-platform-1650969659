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

  context 'when there are more than 3 rewards' do
    let!(:rewards) { create_list(:reward, 5) }

    it 'shows links to navigate pages' do
      visit rewards_path
      expect(page).to have_link 'Next >'
      click_link 'Next ›'
      expect(page).to have_link '< Prev'
    end

    it 'allows Employee to see 3 rewards per page' do
      visit rewards_path
      expect(page).to have_content reward.title
      expect(page).to have_content rewards[0].title
      expect(page).to have_content rewards[1].title
      expect(page).to have_no_content rewards[2].title
      expect(page).to have_link '2'
      expect(page).to have_no_link '3'
      click_link 'Next ›'
      expect(page).to have_no_content reward.title
      expect(page).to have_content rewards[2].title
      expect(page).to have_content rewards[3].title
      expect(page).to have_content rewards[4].title
    end
  end
end
