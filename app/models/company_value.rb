class CompanyValue < ApplicationRecord
  has_many :kudo, dependent: :destroy, inverse_of: :company_value

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
