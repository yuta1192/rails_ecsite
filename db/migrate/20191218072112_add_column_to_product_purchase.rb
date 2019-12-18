class AddColumnToProductPurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :product_purchases, :delivery_date, :date
    add_column :product_purchases, :delivery_zone, :integer
  end
end
