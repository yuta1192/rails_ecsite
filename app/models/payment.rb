class Payment < ApplicationRecord
  has_many :products
  belongs_to :cart_item

  validates :name, presence: true
  validates :email, presence: true
  validates :purchase_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :validate_purchase_amount_for_stock #購入できる個数制限（在庫以上は買えない）

  private
    def validate_purchase_amount_for_stock
      if self.purchase_amount.present?
        self.cart_items.each do |cart_item|
          name = cart_item.product.name
          stock = cart_item.product.stock
          errors.add(:purchase_amount, "#{name}を購入できるのは#{stock}個までです") if self.purchase_amount > stock
        end
      end
    end
end
