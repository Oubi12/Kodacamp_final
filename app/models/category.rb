class Category < ApplicationRecord
  validates :name, presence: true

  has_many :item_category_ships
  has_many :items, through: :item_category_ships

  default_scope { where(deleted_at: nil) }

  def destroy
    if item_category_ships.exists?
      errors.add(:base, "Cannot delete category with associated items")
      false
    else
      update(deleted_at: Time.current)
    end
  end
end