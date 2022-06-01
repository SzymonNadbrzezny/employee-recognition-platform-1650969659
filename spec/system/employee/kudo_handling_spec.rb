require 'rails_helper'

RSpec.describe 'Kudo handling' do
  let(:employee) { create(:employee, number_of_available_kudos: 1) }
  let!(:receiver) { create(:employee) }
  let!(:company_value) { create(:company_value) }
  let!(:company_value2) { create(:company_value) }

  before do
    sign_in employee
  end

  it 'user to perform CRUD operations around his kudos' do
    visit root_path
    click_link 'New Kudo'
    fill_in 'Title',	with: 'Kudo title'
    fill_in 'Content',	with: 'kudo content'
    select company_value2.title, from: 'Company value'
    click_button 'Create Kudo'
    expect(page).to have_content('Avaible Kudos 0')
    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'Kudo title'
    expect(page).to have_content company_value2.title

    click_link 'Edit'

    fill_in 'Title',	with: 'Kudo edited title'
    select company_value.title, from: 'Company value'
    click_button 'Update Kudo'

    expect(page).to have_content 'Kudo edited title'
    expect(page).to have_content company_value.title
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
  end

  it 'checks if employee has enough available kudos' do
    employee.number_of_available_kudos = 0
    visit root_path
    expect(page).to have_content('Avaible Kudos 0')
    expect(page).to have_button('New Kudo', disabled: true)
  end
end
