class Kudo < ApplicationRecord
  belongs_to :giver, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'

  validates :title, :context, presence: true
end
