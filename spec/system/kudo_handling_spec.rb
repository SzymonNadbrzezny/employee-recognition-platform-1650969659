require 'rails_helper'

RSpec.describe 'Kudo handling' do
  let(:employee) { create(:employee) }
  let!(:receiver) { create(:employee) }

  before do
    sign_in employee
  end

  it 'user to perform CRUD operations around his kudos' do
    visit root_path

    click_link 'New Kudo'
    fill_in 'Title',	with: 'Kudo title'
    fill_in 'Content',	with: 'kudo content'
    click_button 'Create Kudo'

    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'Kudo title'

    click_link 'Edit'

    fill_in 'Title',	with: 'Kudo edited title'
    click_button 'Update Kudo'

    expect(page).to have_content 'Kudo edited title'

    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
