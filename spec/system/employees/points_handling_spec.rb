require 'rails_helper'

RSpec.describe 'Points handling' do
  let!(:receiver) { create(:employee) }

  before do
    sign_in receiver
  end

  it 'checks wheter employee is shown number of points he has' do
    visit root_path
    within('.kudo-container') do
      expect(page).to have_content receiver.points
    end
    create_list(:kudo, 4, receiver: receiver)
    visit root_path
    within('.kudo-container') do
      expect(page).to have_content receiver.points
    end
  end
end
