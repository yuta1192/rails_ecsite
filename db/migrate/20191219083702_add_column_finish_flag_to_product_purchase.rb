class AddColumnFinishFlagToProductPurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :product_purchases, :finish_flag, :boolean, default: false, null: false
  end
end
