class ChangeDataZipCodeToProductPurchaseAndUser < ActiveRecord::Migration[5.2]
  def change
    change_column :product_purchases, :shipping_zip_code, :string
    change_column :users, :zip_code, :string
  end
end
