require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  let!(:company_value) { create(:company_value) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end
end
