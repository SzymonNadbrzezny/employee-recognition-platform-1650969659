require 'rails_helper'

RSpec.describe 'Notifications', type: :mailer do
  describe '- delivery' do
    let!(:employee) { create(:employee, points: 10) }
    let!(:reward) { create(:reward, price: 2) }
    let!(:order) { create(:order, buyer: employee, reward: reward) }
    let(:mail) { NotificationsMailer.with(employee: employee, order: order).notify_of_delivery }

    it 'renders the headers' do
      expect(mail.subject).to have_content 'Confirmation of order delivery', exact: true
      expect(mail.from).to have_content 'gludekpl@gmail.com'
      expect(mail.to).to have_content employee.email
    end

    it 'renders the body' do
      expect(mail.body.encoded).to have_content "Order nr. #{order.id}"
    end
  end
end
