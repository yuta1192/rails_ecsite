class CartItem < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :user
  belongs_to :product_purchase
end
