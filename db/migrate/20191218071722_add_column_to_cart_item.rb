class AddColumnToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :delivery_date, :date
    add_column :cart_items, :delivery_zone, :integer
  end
end
