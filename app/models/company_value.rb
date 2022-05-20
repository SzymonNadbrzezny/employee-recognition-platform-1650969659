# == Schema Information
#
# Table name: company_values
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  unique_titles  (title) UNIQUE
#
class CompanyValue < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
