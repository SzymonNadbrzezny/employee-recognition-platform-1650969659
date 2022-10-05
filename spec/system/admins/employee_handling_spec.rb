require 'rails_helper'

RSpec.describe 'Employee handling allows' do
  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }

  before do
    sign_in admin
  end

  it 'Admin to perform RUD operations around employees' do
    visit admins_root_path

    within('.section') do
      click_link 'Employee list'
    end

    expect(page).to have_content 'Employees'
    expect(page).to have_content employee.email
    expect(page).to have_content 'Edit'
    expect(page).to have_content '10'

    click_link 'Edit'
    expect(page).to have_content 'Number of available kudos'
    expect(page).to have_content 'Editing employee'

    fill_in 'employee_number_of_available_kudos', with: 5
    click_on 'Update'
    expect(page).to have_content employee.email
    expect(page).to have_content '5'
    expect(page).to have_content 'Employee was successfully updated.'

    click_link 'Edit'
    fill_in 'employee_email', with: 'test@test.com'
    click_on 'Update'
    expect(page).to have_content 'test@test.com'
    expect(page).to have_content '5'
    expect(page).to have_content 'Employee was successfully updated.'

    click_link 'Edit'
    fill_in 'employee_password', with: 'randompassword'
    click_on 'Update'
    expect(page).to have_content 'test@test.com'
    expect(page).to have_content '5'
    expect(page).to have_content 'Employee was successfully updated.'
    click_link 'Edit'
    fill_in 'employee_first_name', with: 'Stefan'
    fill_in 'employee_last_name', with: 'Grzegrzółka'
    click_on 'Update'
    expect(page).to have_content 'Employee was successfully updated.'
    click_link 'Profile'
    expect(page).to have_content 'Stefan'
    expect(page).to have_content 'Grzegrzółka'
    visit root_path

    expect(page).to have_content 'Log in'
    fill_in 'Email',	with: 'test@test.com'
    fill_in 'Password',	with: 'randompassword'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Avaible Kudos 5'
    click_link 'Sign out'
    visit admins_employees_path
    click_link 'Destroy'
    expect(page).to have_content 'Employee was successfully destroyed.'
  end

  it 'Admin to add kudos to all employees' do
    visit admins_employees_path

    expect(page).to have_content 'Add kudos'
    expect(page).to have_content employee.number_of_available_kudos
    old_kudos = employee.number_of_available_kudos
    click_link 'Add kudos'

    fill_in 'number_of_kudos_to_add', with: 5
    click_button 'Add Kudos'
    expect(page).to have_content 'Kudos were added successfuly.'
    expect(page).to have_no_content old_kudos, exact: true
    expect(page).to have_content old_kudos + 5
  end
end
