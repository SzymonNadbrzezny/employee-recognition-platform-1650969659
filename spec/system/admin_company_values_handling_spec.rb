require 'rails_helper'

RSpec.describe 'Company Values handling allows' do
  let!(:admin) { create(:admin) }
  let!(:company_value) { create(:company_value) }

  before do
    sign_in admin
  end

  it 'Admin to perform CRUD operations around company values' do
    visit admins_root_path

    within('.section') do
      click_link 'Company Values list'
    end

    expect(page).to have_content 'Company Values'
    expect(page).to have_content company_value.title
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'

    click_link 'New Company Value'
    expect(page).to have_content 'New Company Value'
    expect(page).to have_content 'Title'

    fill_in 'company_value_title', with: company_value.title
    click_on 'Create Company value'
    expect(page).to have_content 'Title has already been taken'
    fill_in 'company_value_title', with: 'new test title'
    click_on 'Create Company value'
    expect(page).to have_content 'Company Value was successfully created.'

    click_link 'Edit', match: :first
    fill_in 'company_value_title', with: 'new test title'
    click_on 'Update Company value'
    expect(page).to have_content 'Title has already been taken'
    fill_in 'company_value_title', with: 'title'
    click_on 'Update Company value'
    expect(page).to have_content 'Company Value was successfully updated.'
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Company Value was successfully destroyed.'
  end
end
