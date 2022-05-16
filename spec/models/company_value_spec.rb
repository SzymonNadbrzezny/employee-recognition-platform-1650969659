require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  let!(:company_value) { create(:company_value) }
  let!(:company_value2) { create(:company_value, title: 'test') }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).case_insensitive }
  end
end
