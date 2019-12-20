class CartItem < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :user

  enum delivery_zone: {
    午前中: 1, "14時から16時": 2, "16時から18時": 3, "18時から20時": 4, "19時から21時": 5
  }
end
