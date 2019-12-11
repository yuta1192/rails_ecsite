class ProductPurchase < ApplicationRecord
  belongs_to :user
  belongs_to :cart_item
  belongs_to :product
end
