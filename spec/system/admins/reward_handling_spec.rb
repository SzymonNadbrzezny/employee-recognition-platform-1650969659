require 'rails_helper'

RSpec.describe 'Rewards handling allows' do
  let!(:admin) { create(:admin) }
  let!(:reward) { create(:reward) }
  let!(:category) { create(:category) }

  after do
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end

  before do
    sign_in admin
  end

  it 'Admin to perform CRUD operations around Rewards' do
    visit admins_root_path

    within('.section') do
      click_link 'Rewards list'
    end

    expect(page).to have_content 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'

    click_link 'New Reward'
    expect(page).to have_content 'New Reward'
    expect(page).to have_content 'Title'

    fill_in 'reward_title', with: 'new test title'
    click_on 'Create Reward'
    expect(page).to have_content 'Description can\'t be blank'
    expect(page).to have_content 'Categories can\'t be blank'
    expect(page).to have_content 'Price can\'t be blank'
    fill_in 'reward_description', with: 'new description'
    click_on 'Create Reward'
    expect(page).to have_no_content 'Description can\'t be blank'
    fill_in 'reward_price', with: 0.5
    click_on 'Create Reward'
    expect(page).to have_content 'Price must be greater than or equal to 1'
    fill_in 'reward_price', with: 3.5
    click_on 'Create Reward'
    expect(page).to have_no_content 'Price must be greater than or equal to 1'
    select category.title, from: 'category_ids', match: :smart
    click_on 'Create Reward'

    expect(page).to have_content 'new test title'
    expect(page).to have_content 'new description'
    expect(page).to have_content '3.5'
    expect(page).to have_content 'Reward was successfully created.'

    click_link 'Edit', match: :first
    fill_in 'reward_title', with: 'title'
    click_on 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated.'
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Reward was successfully destroyed.'
  end

  it 'Admin to attach photo to Reward' do
    visit admins_rewards_path
    click_link 'Edit'
    attach_file 'reward_picture', Rails.root.join('spec/fixtures/files/rewards/reward_photo.png')
    click_on 'Update Reward'
    reward.reload
    expect(reward.picture.attached?).to eq true
    expect(page).to have_content 'Reward was successfully updated.'
  end

  it 'Admin to change delivery method of Reward to post' do
    visit admins_rewards_path
    click_link 'Edit'
    select 'post', from: 'reward_delivery_method', match: :smart
    click_on 'Update Reward'
  end

  context 'when Admin wants to import rewards' do
    reward_file_path = Rails.root.join('spec/fixtures/files/rewards/rewards_import/')
    let!(:import_category) { create(:category, title: 'ImportCategory') }
    let!(:import_category2) { create(:category, title: 'ImportCategory2') }
    let!(:reward) { create(:reward, title: 'reward_title1') }

    it '- fails when one of imported rewards has incorrect category' do
      visit admins_rewards_path
      click_link 'Import Rewards'
      attach_file 'reward_file', reward_file_path.join('rewards_incorrect_category.csv')
      click_button 'Import Rewards'
      expect(page).to have_content 'Category with this title doesn\'t exit in row: 0'
    end

    it '- succedes when file is correct' do
      visit admins_rewards_path
      expect(page).to have_content reward.title
      expect(page).to have_content reward.description
      click_link 'Import Rewards'
      attach_file 'reward_file', reward_file_path.join('rewards_correct.csv')
      click_button 'Import Rewards'
      expect(page).to have_content 'Successfuly imported 2 rewards.'
      reward.reload
      expect(reward.categories[0]).to eq(import_category2)
      expect(page).to have_content 'reward_title2'
      expect(page).to have_content 'reward_description'
      expect(page).to have_content reward.title
      expect(page).to have_content 'modified_reward_desc'
    end
  end
end
