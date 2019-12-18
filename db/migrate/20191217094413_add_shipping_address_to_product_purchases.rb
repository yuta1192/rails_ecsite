class AddShippingAddressToProductPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :product_purchases, :shipping_zip_code, :integer
    add_column :product_purchases, :shipping_prefectures, :string
    add_column :product_purchases, :shipping_address, :string
  end
end
