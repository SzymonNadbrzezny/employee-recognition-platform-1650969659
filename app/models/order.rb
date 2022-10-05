class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'Employee'
  belongs_to :reward
  enum status: { awaiting_delivery: 0, delivered: 1 }
  scope :ordered_by_status, ->(ordering_method = 'asc') { order(status: ordering_method) }
  serialize :address_snapshot
end
