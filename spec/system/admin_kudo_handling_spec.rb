require 'rails_helper'

RSpec.describe 'Kudo handling' do
  let!(:admin) { create(:admin) }
  let!(:kudo) { create(:kudo) }

  before do
    sign_in admin
  end

  it 'user to perform CRUD operations around his kudos' do
    visit admins_root_path

    within('.section') do
      click_link 'Kudo list'
    end

    expect(page).to have_content 'Kudos'
    expect(page).to have_content 'Kudo-test'

    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
