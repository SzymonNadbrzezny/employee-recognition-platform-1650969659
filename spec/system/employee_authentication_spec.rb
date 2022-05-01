require 'rails_helper'

RSpec.describe 'Employee authentication actions' do
	let(:employee) { build(:employee) }

	it 'allow to create account, log out and log in' do
		visit root_path

		click_link 'Sign up'
		fill_in "Email",	with: employee.email
		fill_in "Password",	with: employee.password
		fill_in "Password confirmation",	with: employee.password
		click_button 'Sign up'

		expect(page).to have_content 'Welcome! You have signed up successfully.'

		click_link 'Sign out'

		expect(page).to have_content 'You need to sign in or sign up before continuing.'

		expect(page).to have_content 'Log in'
		fill_in "Email",	with: employee.email
		fill_in "Password",	with: employee.password
		click_button 'Log in'
		expect(page).to have_content 'Signed in successfully.'
		click_link 'Sign out'

		expect(page).to have_content 'You need to sign in or sign up before continuing.'
	end
end