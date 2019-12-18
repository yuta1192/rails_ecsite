class ChangeDataOrderIdToProductPurchases < ActiveRecord::Migration[5.2]
  def change
    change_column :product_purchases, :order_id, :string
  end
end
