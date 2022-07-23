class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'Employee'
  serialize :reward, JSON
  enum status: { awaiting_delivery: 'awaiting_delivery', delivered: 'delivered' }
  scope :ordered_by_status, ->(ordering_method = 'asc') { order(status: ordering_method) }
  scope :undelivered, -> { where(status: :awaiting_delivery) }
end
