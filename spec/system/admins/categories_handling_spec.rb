require 'rails_helper'

RSpec.describe 'Category handling allows' do
  let!(:admin) { create(:admin) }
  let!(:category) { create(:category) }

  before do
    sign_in admin
  end

  it 'Admin to perform CRUD operations around company values' do
    visit admins_root_path
    within('.section') do
      click_link 'Category list'
    end

    expect(page).to have_content 'Categories'
    expect(page).to have_content category.title
    expect(page).to have_content 'New Category'
    click_on 'New Category'
    fill_in 'category_title', with: 'Newest'
    click_button 'Create Category'
    expect(page).to have_content 'Category was successfully created.'

    click_link 'Rewards list'
    click_link 'New Reward'
    expect(page).to have_content 'New Reward'
    fill_in 'reward_title', with: 'New Reward'
    fill_in 'reward_description', with: 'new description'
    fill_in 'reward_price', with: 3.5
    click_on 'Create Reward'
    expect(page).to have_content 'Categories can\'t be blank'
    select 'Newest', from: 'categories'
    click_on 'Create Reward'
    expect(page).to have_no_content 'Categories can\'t be blank'
  end
end
