require 'rails_helper'

RSpec.describe 'Employee authentication actions' do
  let(:employee) { build(:employee) }
  let(:saved_employee) { create(:employee) }

  it 'allow to create account, log out and log in' do
    visit root_path

    within('.section') do
      click_link 'Sign up'
    end
    fill_in 'Email',	with: employee.email
    fill_in 'First name',	with: employee.first_name
    fill_in 'Last name',	with: employee.last_name
    fill_in 'Password',	with: employee.password
    fill_in 'Password confirmation',	with: employee.password
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'Avaible Kudos 10'

    click_link 'Sign out'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'

    expect(page).to have_content 'Log in'
    fill_in 'Email',	with: employee.email
    fill_in 'Password',	with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    click_link 'Sign out'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  it 'allows to change first and last name' do
    sign_in saved_employee
    visit employee_path(saved_employee)

    expect(page).to have_content saved_employee.first_name
    expect(page).to have_content saved_employee.last_name

    click_link 'Edit'

    fill_in 'First name',	with: 'Stefan'
    fill_in 'Last name',	with: 'Grzegrzółka'

    click_button 'Update'

    expect(page).to have_content 'Stefan'
    expect(page).to have_content 'Grzegrzółka'
  end
end
