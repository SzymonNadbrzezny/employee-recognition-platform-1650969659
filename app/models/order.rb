class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'Employee'
  serialize :reward, JSON
end
