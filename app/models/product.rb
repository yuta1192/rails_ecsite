class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true
  validates :description, presence: true
  has_many :cart_items
end
