# == Schema Information
#
# Table name: company_values
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  unique_titles  (title) UNIQUE
#
require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  let!(:company_value) { create(:company_value) }
  let!(:company_value2) { create(:company_value, title: 'test') }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end
end
