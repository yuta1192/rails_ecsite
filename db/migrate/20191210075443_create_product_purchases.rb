class CreateProductPurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :product_purchases do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :num
      t.timestamps
    end
  end
end
