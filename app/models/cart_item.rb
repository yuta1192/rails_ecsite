class CartItem < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :user
  has_many :payments
end
