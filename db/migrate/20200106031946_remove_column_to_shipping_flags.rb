class RemoveColumnToShippingFlags < ActiveRecord::Migration[5.2]
  def change
    remove_column :product_purchases, :shipping_posshible, :boolean, default: false, null: false
    remove_column :product_purchases, :shipping_start, :boolean, default: false, null: false
    remove_column :product_purchases, :shipping_done, :boolean, default: false, null: false
  end
end
