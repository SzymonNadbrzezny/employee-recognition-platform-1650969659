# == Schema Information
#
# Table name: rewards
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  price       :decimal(, )      not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Reward < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
end
