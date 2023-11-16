class Item < ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true
  validates :minimum_tickets, presence: true
  validates :batch_count, presence: true

  mount_uploader :image, ImageUploader
  enum status: { inactive: 0, active: 1 }

end