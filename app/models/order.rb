# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  reward     :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  buyer_id   :bigint           not null
#
# Indexes
#
#  index_orders_on_buyer_id  (buyer_id)
#
# Foreign Keys
#
#  fk_rails_...  (buyer_id => employees.id)
#
class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'Employee'
  serialize :reward, JSON
end
