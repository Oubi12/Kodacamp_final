class Address::Province < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  has_many :cities
  belongs_to :region
  has_many :addresses

  def self.table_name_prefix
    "address_"
  end
end