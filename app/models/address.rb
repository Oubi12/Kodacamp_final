class Address < ApplicationRecord
  enum genre: { home:0, office:1 }
  validates :name, presence: true
  validates :street_address, presence: true
  validates :phone_number, phone: {
    possible: true,
    allow_blank: true,
    types: %i[voip mobile],
    countries: [:ph]
  }
  validates :remark, presence: true

  scope :default, -> { find_by(is_default: true) }

  has_many :winners

  belongs_to :barangay
  belongs_to :city
  belongs_to :province
  belongs_to :region
  belongs_to :user

  before_save :validate_address_count

  private

  def validate_address_count
    if self.user.addresses.count >= 5
      self.errors.add(:base, "You can't have more than 5 addresses.")
      false
    end
  end
end