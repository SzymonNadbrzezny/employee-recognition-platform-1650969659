# == Schema Information
#
# Table name: rewards
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  price       :decimal(, )      not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
  end
end
