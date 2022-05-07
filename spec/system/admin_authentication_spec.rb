require 'rails_helper'

RSpec.describe 'Admin authentication actions' do
  let!(:admin) { create(:admin) }

  it 'allow to log in and log out' do
    visit admins_root_path

    expect(page).to have_content 'Log in'
    fill_in 'Email',	with: admin.email
    fill_in 'Password',	with: admin.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    click_link 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
