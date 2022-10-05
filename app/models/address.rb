class Address < ApplicationRecord
  belongs_to :employee

  validates :street, :city, :postal_code, presence: true

  def full_address
    "#{street}, #{postal_code} #{city}"
  end
end
