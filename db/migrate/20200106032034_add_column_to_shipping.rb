class AddColumnToShipping < ActiveRecord::Migration[5.2]
  def change
    add_column :product_purchases, :status, :integer
  end
end
