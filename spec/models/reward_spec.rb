require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_content_type_of(:picture).allowing('image/png', 'image/jpg') }
  end
end
