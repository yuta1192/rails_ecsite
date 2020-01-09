class CreateStockUpdates < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_updates do |t|
      t.references :product, foreign_key: true
      t.integer :product_id
      t.integer :num
      t.timestamps
    end
  end
end
