class Address::Region < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true
  validates :region_name, presence: true

  has_many :provinces

  def self.table_name_prefix
    "address_"
  end
end
